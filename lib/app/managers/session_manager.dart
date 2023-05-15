import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';

class SessionManager {
  late final GetStorage _getStorage;

  SessionManager(this._getStorage);

  final RxList<String> favorites = RxList();
  final RxInt temperature = 0.obs;
  final RxInt wind = 0.obs;
  final RxInt pressure = 0.obs;
  final RxInt precipitataion = 0.obs;
  final RxInt distance = 0.obs;
  final RxInt timeFormat = 0.obs;

  void loadSession() {
    if (_getStorage.read(AppConstant.temperature) == null) {
      _getStorage.write(AppConstant.temperature, 0);
    }

    if (_getStorage.read(AppConstant.wind) == null) {
      _getStorage.write(AppConstant.wind, 0);
    }

    if (_getStorage.read(AppConstant.pressure) == null) {
      _getStorage.write(AppConstant.pressure, 0);
    }

    if (_getStorage.read(AppConstant.precipitataion) == null) {
      _getStorage.write(AppConstant.precipitataion, 0);
    }

    if (_getStorage.read(AppConstant.distance) == null) {
      _getStorage.write(AppConstant.distance, 0);
    }

    if (_getStorage.read(AppConstant.timeFormat) == null) {
      _getStorage.write(AppConstant.timeFormat, 0);
    }

    temperature.value = _getStorage.read(AppConstant.temperature);
    wind.value = _getStorage.read(AppConstant.wind);
    pressure.value = _getStorage.read(AppConstant.pressure);
    precipitataion.value = _getStorage.read(AppConstant.precipitataion);
    distance.value = _getStorage.read(AppConstant.distance);
    timeFormat.value = _getStorage.read(AppConstant.timeFormat);
  }

  void setChangeTemperature(int index) {
    temperature.value = index;
    _getStorage.write(AppConstant.temperature, index);
  }

  void setChangeWind(int index) {
    wind.value = index;
    _getStorage.write(AppConstant.temperature, index);
  }

  void setChangePressure(int index) {
    pressure.value = index;
    _getStorage.write(AppConstant.pressure, index);
  }

  void setChangePrecipitataion(int index) {
    precipitataion.value = index;
    _getStorage.write(AppConstant.precipitataion, index);
  }

  void setChangeDistance(int index) {
    distance.value = index;
    _getStorage.write(AppConstant.distance, index);
  }

  void setChangeTimeFormat(int index) {
    timeFormat.value = index;
    _getStorage.write(AppConstant.timeFormat, index);
  }
}
