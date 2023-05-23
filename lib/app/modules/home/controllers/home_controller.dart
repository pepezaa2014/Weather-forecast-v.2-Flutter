import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';

import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/favorite_locations_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class HomeController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final WeatherAPI _weatherAPI = Get.find();
  final FutureWeatherAPI _futureWeatherAPI = Get.find();
  final AirPollutionAPI _airPollutionAPI = Get.find();

  final RxList<Weather> weather = RxList();
  final RxList<FutureWeather> futureWeather = RxList();
  final RxList<AirPollution> airPollution = RxList();

  Rxn<Setting?> dataSetting = Rxn();
  RxList<FavoriteLocations?> dataFavoriteLocations = RxList();

  final isLoadingGetWeather = false.obs;

  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
    dataSetting = _sessionManager.decodedSetting;

    dataFavoriteLocations = _sessionManager.decodedFavoriteLocations;
  }

  @override
  void onReady() {
    super.onReady();

    _getAllData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goLocate() {
    Get.toNamed(Routes.LOCATE_LOCATION);
  }

  @override
  Future<void> refresh() async {
    _determinePosition();
  }

  Future<void> _getAllData() async {
    await _determinePosition();

    for (int index = 1; index < dataFavoriteLocations.length; index++) {
      await _getWeatherLatLon(
        lat: dataFavoriteLocations[index]?.lat ?? 0,
        lon: dataFavoriteLocations[index]?.lon ?? 0,
      );

      await _getFutureWeather(
        lat: dataFavoriteLocations[index]?.lat ?? 0,
        lon: dataFavoriteLocations[index]?.lon ?? 0,
      );

      await _getAirPollution(
        lat: dataFavoriteLocations[index]?.lat ?? 0,
        lon: dataFavoriteLocations[index]?.lon ?? 0,
      );
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlert(
        title: 'Error',
        message: 'Location services are disabled.',
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlert(
          title: 'Error',
          message: 'Location permissions are denied',
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlert(
        title: 'Error',
        message:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    final location = await Geolocator.getCurrentPosition();
    await _getWeatherLatLon(
      lat: location.latitude,
      lon: location.longitude,
    );
    await _getFutureWeather(
      lat: location.latitude,
      lon: location.longitude,
    );
    await _getAirPollution(
      lat: location.latitude,
      lon: location.longitude,
    );

    dataFavoriteLocations[0]?.lat = location.latitude;
    dataFavoriteLocations[0]?.lon = location.longitude;

    _sessionManager.setYourLocation(dataFavoriteLocations);
  }

  Future<void> _getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);
      weather.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getFutureWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _futureWeatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);
      futureWeather.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getAirPollution({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _airPollutionAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);
      airPollution.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
