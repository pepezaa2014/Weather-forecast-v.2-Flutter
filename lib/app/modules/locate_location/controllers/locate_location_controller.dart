import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:weather_v2_pepe/app/core/api/geocoding_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class LocateLocationController extends GetxController
    with WidgetsBindingObserver {
  final SessionManager _sessionManager = Get.find();

  final GeocodingAPI _geocodingAPI = Get.find();
  final WeatherAPI _weatherAPI = Get.find();

  final TextEditingController searchTextCityController =
      TextEditingController();
  final RxString searchCityText = ''.obs;

  late final Rxn<Weather> currentLocation;
  late final Rx<Setting> dataSetting;
  late final RxList<Weather> dataFavoriteLocations;

  final RxList<Geocoding> geocoding = RxList();

  late final RxBool isLoading;
  late final RxBool tick;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    tick = _sessionManager.tick;
    isLoading = _sessionManager.isLoading;

    dataSetting = _sessionManager.dataSetting;
    dataFavoriteLocations = _sessionManager.dataFavoriteLocations;
    currentLocation = _sessionManager.currentLocation;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _sessionManager.active.value = true;
    } else if (state == AppLifecycleState.paused) {
      _sessionManager.active.value = false;
    }
  }

  Future<void> updateWeather() async {
    _sessionManager.updateWeather();
    return;
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

  @override
  void dispose() {
    super.dispose();
    _sessionManager.timerData.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<Weather?> _findSelectedCountryByLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoading(true);
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoading(false);

      return result;
    } catch (error) {
      isLoading(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
      return null;
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

  Future<void> changeDataAndGoShowDetail(Geocoding? item) async {
    goShowDetail(
      await _findSelectedCountryByLatLon(
        lat: item?.lat ?? 0.0,
        lon: item?.lon ?? 0.0,
      ),
    );
  }

  void goOpenMap() {
    FocusNode().unfocus();
    Get.toNamed(Routes.MAP);
  }

  void goSetting() {
    FocusNode().unfocus();
    Get.toNamed(Routes.SETTING);
  }

  void deleteFavoriteIndex(int index) {
    dataFavoriteLocations.removeAt(index - 1);
    updateWeather();
  }

  void goShowDetail(Weather? item) {
    FocusNode().unfocus();

    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    );
  }
}
