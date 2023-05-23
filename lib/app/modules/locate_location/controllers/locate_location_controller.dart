import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
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

  final Rxn<FavoriteLocations?> yourLocationNow = Rxn();

  final TextEditingController searchTextCityController =
      TextEditingController();
  final RxString searchCityText = ''.obs;

  final RxList<Weather?> weather = RxList();
  final RxList<Geocoding?> geocoding = RxList();
  final Rxn<Setting?> dataSetting = Rxn();

  final Rx<Temperature?> temperatureUnit = Temperature.celcius.obs;
  final Rx<Time?> timeUnit = Time.h24.obs;

  final RxList<FavoriteLocations?> dataFavoriteLocations = RxList();

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() async {
    super.onInit();
    dataSetting.value = _sessionManager.decodedSetting.value;
    dataFavoriteLocations.value = _sessionManager.decodedFavoriteLocations;

    temperatureUnit.value = dataSetting.value?.temperatureData;
    timeUnit.value = dataSetting.value?.timeData;

    yourLocationNow.value = dataFavoriteLocations[0];

    await _updateWeatherLatLon();
  }

  Future<void> _updateWeatherLatLon() async {
    weather.clear();
    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      await _getWeatherLatLon(
        lat: dataFavoriteLocations[index]?.lat ?? 0,
        lon: dataFavoriteLocations[index]?.lon ?? 0,
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

  void changeDataAndGoShowDetail(Geocoding? item) {
    final result = FavoriteLocations.fromJson(
      {
        'lat': item?.lat,
        'lon': item?.lon,
      },
    );
    FocusNode().unfocus();
    goShowDetail(result);
  }

  void goOpenMap(FavoriteLocations? item) {
    FocusNode().unfocus();
    Get.toNamed(
      Routes.MAP,
      arguments: item,
    );
  }

  void goSetting() {
    FocusNode().unfocus();
    Get.toNamed(
      Routes.SETTING,
    );
  }

  void deleteFavoriteIndex(int index) {
    _sessionManager.decodedFavoriteLocations.removeAt(index);
    _sessionManager.setDeleteFavorite();
  }

  void goShowDetail(FavoriteLocations? item) {
    FocusNode().unfocus();

    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    )?.then((value) => _updateWeatherLatLon());
  }

  void clearTextField() {
    searchCityText.value = '';
  }

  Future<void> _getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      weather.add(result);
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
      geocoding(result);
    } catch (error) {
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
