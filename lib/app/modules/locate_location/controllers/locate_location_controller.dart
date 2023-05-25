import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/core/api/geocoding_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/favorite_locations_model.dart';
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

  final Rxn<Weather?> yourLocationNow = Rxn();
  final Rxn<Weather?> weatherResult = Rxn();

  final TextEditingController searchTextCityController =
      TextEditingController();
  final RxString searchCityText = ''.obs;

  final RxList<Geocoding?> geocoding = RxList();
  final Rxn<Setting?> dataSetting = Rxn();

  final RxList<Weather?> dataFavoriteLocations = RxList();
  final RxList<Weather?> allWeatherData = RxList();

  late final Weather? currentLocation;

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
    dataSetting.value = _sessionManager.decodedSetting.value;
    dataFavoriteLocations.value = _sessionManager.decodedFavoriteLocations;

    yourLocationNow.value = _sessionManager.decodedCurrentLocation.value;
    currentLocation = _sessionManager.decodedCurrentLocation.value;
    _updateWeather();
  }

  void _updateWeather() {
    allWeatherData.clear();
    if (yourLocationNow != null) {
      allWeatherData.add(yourLocationNow.value);
    }

    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      allWeatherData.add(dataFavoriteLocations[index]);
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
      weatherResult.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> changeDataAndGoShowDetail(Geocoding? item) async {
    await _getWeatherLatLon(
      lat: item?.lat ?? 0.0,
      lon: item?.lon ?? 0.0,
    );

    FocusNode().unfocus();
    goShowDetail(weatherResult.value);
  }

  void goOpenMap(Weather? item) {
    FocusNode().unfocus();
    Get.toNamed(
      Routes.MAP,
      arguments: item,
    )?.then((value) => _updateWeather());
  }

  void goSetting() {
    FocusNode().unfocus();
    Get.toNamed(
      Routes.SETTING,
    )?.then((value) => _updateWeather());
  }

  void deleteFavoriteIndex(int index) {
    _sessionManager.decodedFavoriteLocations.removeAt(index);
    _sessionManager.setDeleteFavorite();
    _updateWeather();
  }

  void goShowDetail(Weather? item) {
    FocusNode().unfocus();

    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    )?.then((value) => _updateWeather());
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
