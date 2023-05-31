import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
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

  late final Rx<Setting> dataSetting;
  late final RxList<Weather> dataFavoriteLocations;

  late final Rxn<Weather> currentLocation;
  late final RxList<FutureWeather> allFutureWeather;
  late final RxList<AirPollution> allAirPollution;

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  @override
  void onInit() {
    super.onInit();
    dataSetting = _sessionManager.dataSetting;
    dataFavoriteLocations = _sessionManager.dataFavoriteLocations;

    currentLocation = _sessionManager.currentLocation;
    allFutureWeather = _sessionManager.allFutureWeather;
    allAirPollution = _sessionManager.allAirPollution;
  }

  @override
  void onReady() {
    super.onReady();
    _updateWeather();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future<void> refresh() async {
    _updateWeather();
  }

  void _updateWeather() {
    allFutureWeather.clear();
    allAirPollution.clear();

    _getAllData();

    allFutureWeather.refresh();
    allAirPollution.refresh();
  }

  void goLocate() {
    Get.toNamed(Routes.LOCATE_LOCATION);
  }

  Future<void> _getAllData() async {
    _determinePosition();
    allFutureWeather.refresh();
    allAirPollution.refresh();

    _getAllWeatherInFavorite();
    allFutureWeather.refresh();
    allAirPollution.refresh();
  }

  Future<void> _getAllWeatherInFavorite() async {
    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      _getWeatherLatLon(
        lat: dataFavoriteLocations[index].coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index].coord?.lon ?? 0.0,
      );
      _getFutureWeather(
        lat: dataFavoriteLocations[index].coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index].coord?.lon ?? 0.0,
      );
      _getAirPollution(
        lat: dataFavoriteLocations[index].coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index].coord?.lon ?? 0.0,
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

    _getCurrentWeatherLatLon(
      lat: location.latitude,
      lon: location.longitude,
    );

    _getFutureWeather(
      lat: location.latitude,
      lon: location.longitude,
    );

    _getAirPollution(
      lat: location.latitude,
      lon: location.longitude,
    );
  }

  Future<void> _getCurrentWeatherLatLon({
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
      currentLocation.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
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

      int index = dataFavoriteLocations
          .indexWhere((element) => element.id == result.id);
      dataFavoriteLocations[index] = result;
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
      allFutureWeather.add(result);
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
      allAirPollution.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
