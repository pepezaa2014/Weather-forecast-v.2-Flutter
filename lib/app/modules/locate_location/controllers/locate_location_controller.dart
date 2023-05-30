import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/core/api/geocoding_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
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

  late final Rx<Weather> currentLocation;
  late final Rx<Setting> dataSetting;
  late final RxList<Weather> dataFavoriteLocations;

  final RxList<Weather> allWeatherData = RxList();

  final RxList<Geocoding> geocoding = RxList();
  final Rx<Weather> selectedCountry = Rx<Weather>(Weather());

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();

    currentLocation = _sessionManager.currentLocation;
    dataSetting = _sessionManager.dataSetting;
    dataFavoriteLocations = _sessionManager.dataFavoriteLocations;
    _updateWeather();
  }

  void _updateWeather() {
    allWeatherData.clear();

    if (currentLocation != null) {
      _getWeatherLatLon(
        lat: currentLocation.value.coord?.lat ?? 0.0,
        lon: currentLocation.value.coord?.lon ?? 0.0,
      );
    }

    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      _getWeatherLatLon(
        lat: dataFavoriteLocations[index].coord?.lat ?? 0.0,
        lon: dataFavoriteLocations[index].coord?.lon ?? 0.0,
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
      allWeatherData.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _findSelectedCountryByLatLon({
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
      selectedCountry.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> changeDataAndGoShowDetail(Geocoding? item) async {
    await _findSelectedCountryByLatLon(
      lat: item?.lat ?? 0.0,
      lon: item?.lon ?? 0.0,
    );
    goShowDetail(selectedCountry.value);
  }

  void goOpenMap() {
    FocusNode().unfocus();
    Get.toNamed(Routes.MAP);
  }

  void goSetting() {
    FocusNode().unfocus();
    Get.toNamed(
      Routes.SETTING,
    );
  }

  void deleteFavoriteIndex(int index) {
    _sessionManager.dataFavoriteLocations.removeAt(index - 1);
    _updateWeather();
  }

  void goShowDetail(Weather item) {
    FocusNode().unfocus();

    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    );
  }

  void clearTextField() {
    searchCityText.value = '';
  }

  void _getGeocoding({
    required String cityName,
  }) async {
    try {
      final result = await _geocodingAPI.getWeatherCity(
        city: cityName,
      );
      geocoding(result);
    } catch (error) {
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
