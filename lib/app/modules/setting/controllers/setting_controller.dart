import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';

class SettingController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final Rxn<Setting?> dataSetting = Rxn();

  @override
  void onInit() {
    super.onInit();
    dataSetting.value = _sessionManager.decodedSetting.value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeSettingTemp(Temperature? value) {
    final result = Temperature.values.firstWhereOrNull((e) => e == value);
    dataSetting.value?.temperature = result;
    _sessionManager.setChangeTemperature(result);
  }

  void changeSettingWind(WindSpeed? value) {
    final result = WindSpeed.values.firstWhereOrNull((e) => e == value);
    dataSetting.value?.windSpeed = result;
    _sessionManager.setChangeWind(result);
  }

  void changeSettingPressure(Pressure? value) {
    final result = Pressure.values.firstWhereOrNull((e) => e == value);
    dataSetting.value?.pressure = result;
    _sessionManager.setChangePressure(result);
  }

  void changeSettingPrecipitataion(Precipitation? value) {
    final result = Precipitation.values.firstWhereOrNull((e) => e == value);
    dataSetting.value?.precipitation = result;
    _sessionManager.setChangePrecipitataion(result);
  }

  void changeSettingDistance(Distance? value) {
    final result = Distance.values.firstWhereOrNull((e) => e == value);
    dataSetting.value?.distance = result;
    _sessionManager.setChangeDistance(result);
  }

  void changeSettingTime(Time? value) {
    final result = Time.values.firstWhereOrNull((e) => e == value);
    dataSetting.value?.timeFormat = result;
    _sessionManager.setChangeTimeFormat(result);
  }
}
