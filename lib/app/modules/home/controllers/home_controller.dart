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

  final Rxn<Weather> currentLocation = Rxn();
  final Rxn<FutureWeather> currentFutureWeather = Rxn();
  final Rxn<AirPollution> currentAirPollution = Rxn();

  late final Rx<Setting> dataSetting;
  late final RxList<Weather?> dataFavoriteLocations;

  final RxList<Weather?> getAllWeather = RxList();

  final RxList<Weather?> allWeatherData = RxList();
  final RxList<FutureWeather?> allFutureWeather = RxList();
  final RxList<AirPollution?> allAirPollution = RxList();

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
    Get.toNamed(
      Routes.LOCATE_LOCATION,
      arguments: currentLocation,
    )?.then((value) => _updateWeather());
  }

  @override
  Future<void> refresh() async {
    await _getAllData();
  }

  Future<void> _getAllData() async {
    await _getYourLocation();

    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      allWeatherData.add(dataFavoriteLocations[index]);

      _getWeatherLatLon(
        lat: dataFavoriteLocations[index]?.coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index]?.coord?.lon ?? 0.0,
      );

      _getFutureWeather(
        lat: dataFavoriteLocations[index]?.coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index]?.coord?.lon ?? 0.0,
      );
      _getAirPollution(
        lat: dataFavoriteLocations[index]?.coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index]?.coord?.lon ?? 0.0,
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
      getAllWeather.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getYourLocation() async {
    await _determinePosition();
    if (currentLocation != null) {
      allWeatherData.add(currentLocation.value);
      getAllWeather.add(currentLocation.value);
      allAirPollution.add(currentAirPollution.value);
      allFutureWeather.add(currentFutureWeather.value);
    }
    allWeatherData.refresh();
    getAllWeather.refresh();
    allAirPollution.refresh();
    allFutureWeather.refresh();
  }

  Future<void> _updateWeather() async {
    allWeatherData.clear();
    allAirPollution.clear();
    allFutureWeather.clear();
    _getAllData();
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

    _getCurrentLocation(
      lat: location.latitude,
      lon: location.longitude,
    );

    await _getCurrentFutureWeather(
      lat: location.latitude,
      lon: location.longitude,
    );

    _getCurrentAirPollution(
      lat: location.latitude,
      lon: location.longitude,
    );
  }

  Future<void> _getCurrentLocation({
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

  Future<void> _getCurrentFutureWeather({
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
      currentFutureWeather.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getCurrentAirPollution({
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

      currentAirPollution.value = result;
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
