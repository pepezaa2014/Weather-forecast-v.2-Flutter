import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/distance.dart';
import 'package:weather_v2_pepe/app/const/precipitation.dart';
import 'package:weather_v2_pepe/app/const/pressure.dart';
import 'package:weather_v2_pepe/app/const/temperature.dart';
import 'package:weather_v2_pepe/app/const/time.dart';
import 'package:weather_v2_pepe/app/const/wind_speed.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';

class SettingController extends GetxController with WidgetsBindingObserver {
  final SessionManager _sessionManager = Get.find();

  final Rx<Temperature> temperatureUnit = Temperature.celcius.obs;
  final Rx<WindSpeed> windUnit = WindSpeed.mph.obs;
  final Rx<Pressure> pressureUnit = Pressure.hpa.obs;
  final Rx<Precipitation> precipitationUnit = Precipitation.mm.obs;
  final Rx<Distance> distanceUnit = Distance.km.obs;
  final Rx<Time> timeUnit = Time.h24.obs;

  late final Rx<Setting> dataSetting;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    dataSetting = _sessionManager.dataSetting;

    updateData();
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateData() {
    temperatureUnit.value = dataSetting.value.temperature;
    windUnit.value = dataSetting.value.windSpeed;
    pressureUnit.value = dataSetting.value.pressure;
    precipitationUnit.value = dataSetting.value.precipitation;
    distanceUnit.value = dataSetting.value.distance;
    timeUnit.value = dataSetting.value.timeFormat;
  }

  void changeSettingTemp(Temperature value) {
    temperatureUnit.value = value;
    dataSetting.value.temperature = value;
    _sessionManager.dataSetting.refresh();
  }

  void changeSettingWind(WindSpeed value) {
    windUnit.value = value;
    dataSetting.value.windSpeed = value;
    _sessionManager.dataSetting.refresh();
  }

  void changeSettingPressure(Pressure value) {
    pressureUnit.value = value;
    dataSetting.value.pressure = value;
    _sessionManager.dataSetting.refresh();
  }

  void changeSettingPrecipitataion(Precipitation value) {
    precipitationUnit.value = value;
    dataSetting.value.precipitation = value;
    _sessionManager.dataSetting.refresh();
  }

  void changeSettingDistance(Distance value) {
    distanceUnit.value = value;
    dataSetting.value.distance = value;
    _sessionManager.dataSetting.refresh();
  }

  void changeSettingTime(Time value) {
    timeUnit.value = value;
    dataSetting.value.timeFormat = value;
    _sessionManager.dataSetting.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _sessionManager.timerData.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }
}
