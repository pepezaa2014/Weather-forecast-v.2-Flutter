import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
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

  late final Rxn<Weather> currentLocation;
  late final Rx<Setting> dataSetting;

  late final RxList<Weather?> dataFavoriteLocations;
  late final RxList<FutureWeather?> dataFutureWeather;
  late final RxList<AirPollution?> dataAirPollution;
  final RxList<Weather?> allWeatherInFavorite = RxList();

  final RxList<Weather?> allWeatherData = RxList();
  final RxList<FutureWeather> allFutureWeather = RxList();
  final RxList<AirPollution> allAirPollution = RxList();

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

    currentLocation = _sessionManager.decodedCurrentLocation;

    dataSetting = _sessionManager.decodedSetting;

    dataFavoriteLocations = _sessionManager.decodedFavoriteLocations;

    if (dataFavoriteLocations[0]?.id == null) {
      dataFavoriteLocations.removeAt(0);
    }

    dataAirPollution = _sessionManager.decodedAirpollution;
    dataFutureWeather = _sessionManager.decodedFuture;
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
    Get.toNamed(Routes.LOCATE_LOCATION)?.then((value) => _updateWeather());
  }

  @override
  Future<void> refresh() async {
    await _getAllData();
  }

  Future<void> _getAllData() async {
    await _determinePosition();
    if (currentLocation != null) {
      allWeatherData.add(currentLocation.value);

      // _sessionManager.setNewCurrentLocation(currentLocation.value);

      // _getFutureWeather(
      //   lat: currentLocation.value?.coord?.lat ?? 0,
      //   lon: currentLocation.value?.coord?.lon ?? 0,
      //   index: 0,
      // );
      // _getAirPollution(
      //   lat: currentLocation.value?.coord?.lat ?? 0.0,
      //   lon: currentLocation.value?.coord?.lon ?? 0.0,
      //   index: 0,
      // );
    }
    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      allWeatherData.add(dataFavoriteLocations[index]);
    }
    // print(allWeatherData[1]);
  }

  Future<void> _updateWeather() async {
    allWeatherData.clear();
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

    await _getCurrentLocation(
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

  Future<void> _getFutureWeather({
    required double lat,
    required double lon,
    required int index,
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
    required int index,
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
