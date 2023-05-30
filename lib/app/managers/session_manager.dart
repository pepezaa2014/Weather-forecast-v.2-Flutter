import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constants.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

class SessionManager {
  late final GetStorage _getStorage;

  final Rx<Setting> dataSetting = Setting().obs;
  final RxList<Weather> dataFavoriteLocations = RxList();
  final Rx<Weather> currentLocation = Rx<Weather>(Weather());
  final RxList<FutureWeather> allFutureWeather = RxList();
  final RxList<AirPollution> allAirPollution = RxList();

  SessionManager(this._getStorage) {
    dataSetting.listen(
      (p0) {
        final unitSettingsString = json.encode(p0.toJson());
        _getStorage.write(AppConstants.keyValueSetting, unitSettingsString);
      },
    );

    dataFavoriteLocations.listen(
      (p0) {
        final weatherListString =
            p0.map((e) => json.encode(e.toJson())).toList();
        _getStorage.write(
            AppConstants.keyValueFavoriteLocation, weatherListString);
      },
    );
  }

  void loadSession() {
    _getStorage.remove(AppConstants.keyValueSetting);
    _getStorage.remove(AppConstants.keyValueFavoriteLocation);

    var checkedSetting = _getStorage.read(AppConstants.keyValueSetting);
    if (checkedSetting != null) {
      dataSetting.value = Setting.fromJson(jsonDecode(checkedSetting));
    }

    final checkedFavorite =
        _getStorage.read(AppConstants.keyValueFavoriteLocation);
    if (checkedFavorite != null) {
      for (int i = 0; i < checkedFavorite.length; i++) {
        dataFavoriteLocations
            .add(Weather.fromJson(jsonDecode(checkedFavorite[i])));
      }
    }
  }
}
