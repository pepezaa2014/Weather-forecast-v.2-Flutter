import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';

class SettingController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final RxInt temperatureUnit = 0.obs;
  final RxInt windUnit = 0.obs;
  final RxInt pressureUnit = 0.obs;
  final RxInt precipitationUnit = 0.obs;
  final RxInt distanceUnit = 0.obs;
  final RxInt timeUnit = 0.obs;
  final Rxn<Setting?> dataSetting = Rxn();

  @override
  void onInit() {
    super.onInit();
    updateData();
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
    dataSetting.value = _sessionManager.decoded.value;
    // print('Start Now');
    // print('=================================');
    // _sessionManager.printText();
    // print('This is controller');
    // print('=================================');
    // print(dataSetting.value);
    // print(dataSetting.value?.temperature);

    temperatureUnit.value = dataSetting.value?.temperature ?? 0;
    windUnit.value = dataSetting.value?.windSpeed ?? 0;
    pressureUnit.value = dataSetting.value?.pressure ?? 0;
    precipitationUnit.value = dataSetting.value?.precipitation ?? 0;
    distanceUnit.value = dataSetting.value?.distance ?? 0;
    timeUnit.value = dataSetting.value?.timeFormat ?? 0;
  }

  void changeSettingTemp(int index) {
    // print('=================Before Update================');
    // print(temperatureUnit);
    // print('=================After Update================');
    temperatureUnit.value = index;
    dataSetting.value?.temperature = index;
    _sessionManager.setChangeTemperature(index);
  }

  void changeSettingWind(int index) {
    windUnit.value = index;
    dataSetting.value?.windSpeed = index;
    _sessionManager.setChangeWind(index);
  }

  void changeSettingPressure(int index) {
    pressureUnit.value = index;
    dataSetting.value?.pressure = index;
    _sessionManager.setChangePressure(index);
  }

  void changeSettingPrecipitataion(int index) {
    precipitationUnit.value = index;
    dataSetting.value?.precipitation = index;
    _sessionManager.setChangePrecipitataion(index);
  }

  void changeSettingDistance(int index) {
    distanceUnit.value = index;
    dataSetting.value?.distance = index;
    _sessionManager.setChangeDistance(index);
  }

  void changeSettingTime(int index) {
    timeUnit.value = index;
    dataSetting.value?.timeFormat = index;
    _sessionManager.setChangeTimeFormat(index);
  }
}
