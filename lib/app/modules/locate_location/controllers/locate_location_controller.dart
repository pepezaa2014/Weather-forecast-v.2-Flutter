import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/core/api/geocoding_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class LocateLocationController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final GeocodingAPI _geocodingAPI = Get.find();
  final WeatherAPI _weatherAPI = Get.find();

  final TextEditingController searchTextCityController =
      TextEditingController();
  final RxString searchCityText = ''.obs;

  late final Rxn<Weather> weather = Rxn();
  late final RxList<Weather> allFavoriteLocations = RxList();
  late final RxList<Geocoding> geocoding = RxList();

  late final RxList<Map<String, dynamic>> favoriteLocation;
  late final RxInt timeUnit;
  late final RxInt temperatureUnit;

  final isLoadingGetWeather = false.obs;

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
    temperatureUnit = _sessionManager.temperature;
    timeUnit = _sessionManager.timeFormat;
    favoriteLocation = _sessionManager.favoriteLocation;

    for (int i = 0; i < favoriteLocation.length; i++) {
      _getAllWeatherLatLon(
        lat: favoriteLocation[i]['lat'],
        lon: favoriteLocation[i]['lon'],
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
    searchTextCityController.addListener(
      () {
        searchCityText.value = searchTextCityController.text;
        if (searchCityText.value != '') {
          _getGeocoding(
            cityName: searchCityText.value,
          );
        }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goSetting() {
    Get.toNamed(Routes.SETTING);
  }

  void deleteFavoriteIndex(int index) {
    _sessionManager.favoriteLocation.removeAt(index);
  }

  void goShowDetail(Map<String, dynamic> item) {
    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    );
  }

  void clearTextField() {
    searchCityText.value = '';
  }

  void _getAllWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      allFavoriteLocations.add(result);
    } catch (error) {
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  void getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      weather.value = result;
    } catch (error) {
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  void _getGeocoding({
    required String cityName,
  }) async {
    try {
      final result = await _geocodingAPI.getWeatherCity(
        city: cityName,
      );
      geocoding.value = result;
    } catch (error) {
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
