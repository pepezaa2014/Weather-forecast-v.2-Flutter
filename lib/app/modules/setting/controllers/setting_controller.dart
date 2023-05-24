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

  final Rx<Temperature?> temperatureUnit = Temperature.celcius.obs;
  final Rx<WindSpeed?> windUnit = WindSpeed.mph.obs;
  final Rx<Pressure?> pressureUnit = Pressure.hpa.obs;
  final Rx<Precipitation?> precipitationUnit = Precipitation.mm.obs;
  final Rx<Distance?> distanceUnit = Distance.km.obs;
  final Rx<Time?> timeUnit = Time.h24.obs;
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
    dataSetting.value = _sessionManager.decodedSetting.value;
    temperatureUnit.value = dataSetting.value?.temperatureData;
    windUnit.value = dataSetting.value?.windSpeedData;
    pressureUnit.value = dataSetting.value?.pressureData;
    precipitationUnit.value = dataSetting.value?.precipitationData;
    distanceUnit.value = dataSetting.value?.distanceData;
    timeUnit.value = dataSetting.value?.timeFormat;
  }

  void changeSettingTemp(Temperature? value) {
    final result = Temperature.values.firstWhereOrNull((e) => e == value);
    temperatureUnit.value = result;
    dataSetting.value?.temperature = result;
    _sessionManager.setChangeTemperature(result);
  }

  void changeSettingWind(WindSpeed? value) {
    final result = WindSpeed.values.firstWhereOrNull((e) => e == value);
    windUnit.value = result;
    dataSetting.value?.windSpeed = result;
    _sessionManager.setChangeWind(result);
  }

  void changeSettingPressure(Pressure? value) {
    final result = Pressure.values.firstWhereOrNull((e) => e == value);
    pressureUnit.value = result;
    dataSetting.value?.pressure = result;
    _sessionManager.setChangePressure(result);
  }

  void changeSettingPrecipitataion(Precipitation? value) {
    final result = Precipitation.values.firstWhereOrNull((e) => e == value);
    precipitationUnit.value = result;
    dataSetting.value?.precipitation = result;
    _sessionManager.setChangePrecipitataion(result);
  }

  void changeSettingDistance(Distance? value) {
    final result = Distance.values.firstWhereOrNull((e) => e == value);
    distanceUnit.value = result;
    dataSetting.value?.distance = result;
    _sessionManager.setChangeDistance(result);
  }

  void changeSettingTime(Time? value) {
    final result = Time.values.firstWhereOrNull((e) => e == value);
    timeUnit.value = result;
    dataSetting.value?.timeFormat = result;
    _sessionManager.setChangeTimeFormat(result);
  }
}
