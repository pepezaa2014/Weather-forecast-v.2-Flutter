import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  late final Rx<Setting> dataSetting;
  late final RxList<Weather> dataFavoriteLocations;

  late final Rxn<Weather> currentLocation;
  late final RxList<FutureWeather> allFutureWeather;
  late final RxList<AirPollution> allAirPollution;

  late final RxBool isLoading;
  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  @override
  void onInit() {
    super.onInit();
    isLoading = _sessionManager.isLoading;
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
    return;
  }

  void _updateWeather() {
    _sessionManager.updateWeather();
  }

  void goLocate() {
    Get.toNamed(Routes.LOCATE_LOCATION);
  }
}
