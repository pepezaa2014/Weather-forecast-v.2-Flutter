import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';

class SettingController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  late final RxInt temperatureUnit;
  late final RxInt windUnit;
  late final RxInt pressureUnit;
  late final RxInt precipitationUnit;
  late final RxInt distanceUnit;
  late final RxInt timeUnit;

  // late final Setting? setting;

  @override
  void onInit() {
    super.onInit();

    temperatureUnit = _sessionManager.temperature;
    windUnit = _sessionManager.wind;
    pressureUnit = _sessionManager.pressure;
    precipitationUnit = _sessionManager.precipitataion;
    distanceUnit = _sessionManager.distance;
    timeUnit = _sessionManager.timeFormat;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void changeSetting(Set<Map<String, int>> item) {
  //   _sessionManager.setSetting(item);
  // }

  void changeSettingTemp(int index) {
    _sessionManager.setChangeTemperature(index);
  }

  void changeSettingWind(int index) {
    _sessionManager.setChangeWind(index);
  }

  void changeSettingPressure(int index) {
    _sessionManager.setChangePressure(index);
  }

  void changeSettingPrecipitataion(int index) {
    _sessionManager.setChangePrecipitataion(index);
  }

  void changeSettingDistance(int index) {
    _sessionManager.setChangeDistance(index);
  }

  void changeSettingTime(int index) {
    _sessionManager.setChangeTimeFormat(index);
  }
}
