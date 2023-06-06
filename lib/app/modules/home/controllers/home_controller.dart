import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final SessionManager _sessionManager = Get.find();

  late final Rx<Setting> dataSetting;
  late final RxList<Weather> dataFavoriteLocations;

  late final Rxn<Weather> currentLocation;
  late final RxList<FutureWeather> allFutureWeather;
  late final RxList<AirPollution> allAirPollution;

  late final RxBool active;

  late final RxBool isLoading;
  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  late final RxBool tick;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    active = _sessionManager.active;
    tick = _sessionManager.tick;
    isLoading = _sessionManager.isLoading;
    dataSetting = _sessionManager.dataSetting;
    dataFavoriteLocations = _sessionManager.dataFavoriteLocations;

    currentLocation = _sessionManager.currentLocation;
    allFutureWeather = _sessionManager.allFutureWeather;
    allAirPollution = _sessionManager.allAirPollution;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      active.value = true;
    } else if (state == AppLifecycleState.paused) {
      active.value = false;
    }
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

  @override
  void dispose() {
    super.dispose();
    _sessionManager.timerData.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }
}
