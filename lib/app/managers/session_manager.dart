import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';

class SessionManager {
  late final GetStorage _getStorage;

  SessionManager(this._getStorage);

  // final RxInt temperature = 0.obs;
  // final RxInt wind = 0.obs;
  // final RxInt pressure = 0.obs;
  // final RxInt precipitataion = 0.obs;
  // final RxInt distance = 0.obs;
  // final RxInt timeFormat = 0.obs;

  final RxList<Map<String, double>> favoriteLocation = RxList();
  final Rxn<Setting?> decoded = Rxn();

  void loadSession() {
    if (_getStorage.read(AppConstant.setting) == null) {
      final a = Setting.fromJson(
        {
          'temperature': 0,
          'windSpeed': 0,
          'pressure': 0,
          'precipitation': 0,
          'distance': 0,
          'timeFormat': 0,
        },
      );

      final aEncoded = json.encode(a.toJson());
      _getStorage.write(AppConstant.setting, aEncoded);
    }

    final setting = _getStorage.read(AppConstant.setting);
    //
    // print('Down here 1\n=============');
    // print(setting);
    // print('Down here 2\n=============');
    // print(Setting.fromJson(jsonDecode(setting)));
    // print(decoded.value);
    decoded.value = Setting.fromJson(jsonDecode(setting));
    // print(decoded.value?.distance);
    //
    // print('Down here 3');
    // print(decoded);

    // temperature.value = _getStorage.read(AppConstant.temperature);
    // wind.value = _getStorage.read(AppConstant.wind);
    // pressure.value = _getStorage.read(AppConstant.pressure);
    // precipitataion.value = _getStorage.read(AppConstant.precipitataion);
    // distance.value = _getStorage.read(AppConstant.distance);
    // timeFormat.value = _getStorage.read(AppConstant.timeFormat);

    _getStorage.remove(AppConstant.favoriteLocation);
    if (_getStorage.read(AppConstant.favoriteLocation) == null) {
      _getStorage.write(
        AppConstant.favoriteLocation,
        [
          {
            'lat': 0.0,
            'lon': 0.0,
          },
        ],
      );
    }
    favoriteLocation.value = _getStorage.read(AppConstant.favoriteLocation);
  }

  void setChangeTemperature(int index) {
    decoded.value?.temperature = index;
    // print('=================');
    // print(decoded.value?.temperature);
    final dataEncoded = json.encode(decoded);
    // print('=========Before========');
    // print(_getStorage.read(AppConstant.setting));
    _getStorage.write(AppConstant.setting, dataEncoded);
    // print('=========After=========');
    // print(_getStorage.read(AppConstant.setting));
  }

  void setChangeWind(int index) {
    decoded.value?.windSpeed = index;
    final dataEncoded = json.encode(decoded);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangePressure(int index) {
    decoded.value?.pressure = index;
    final dataEncoded = json.encode(decoded);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangePrecipitataion(int index) {
    decoded.value?.precipitation = index;
    final dataEncoded = json.encode(decoded);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangeDistance(int index) {
    decoded.value?.distance = index;
    final dataEncoded = json.encode(decoded);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangeTimeFormat(int index) {
    decoded.value?.timeFormat = index;
    final dataEncoded = json.encode(decoded);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setYourLocation(RxList<Map<String, double>> item) {
    _getStorage.remove(AppConstant.favoriteLocation);
    _getStorage.write(AppConstant.favoriteLocation, item);
  }
}
