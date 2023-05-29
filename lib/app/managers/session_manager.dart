import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

class SessionManager {
  late final GetStorage _getStorage;
  SessionManager(this._getStorage);

  final RxList<Weather?> decodedFavoriteLocations = RxList();
  final Rx<Setting> decodedSetting = Setting().obs;

  void loadSession() {
    // _getStorage.remove(AppConstant.setting);
    // _getStorage.remove(AppConstant.favoriteLocation);

    var checkedSetting = _getStorage.read(AppConstant.setting);
    if (checkedSetting != null) {
      decodedSetting.value = Setting.fromJson(jsonDecode(checkedSetting));
    }

    final checkedFavorite = _getStorage.read(AppConstant.favoriteLocation);
    if (checkedFavorite != null) {
      for (int i = 0; i < checkedFavorite.length; i++) {
        decodedFavoriteLocations
            .add(Weather.fromJson(jsonDecode(checkedFavorite[i])));
      }
    } else {
      final RxList<Weather?> result = RxList();
      _getStorage.write(AppConstant.favoriteLocation, result);
      decodedFavoriteLocations.value =
          _getStorage.read(AppConstant.favoriteLocation);
    }
  }

  void setChangeTemperature(Temperature index) {
    decodedSetting.value.temperature = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
    decodedSetting.refresh();
  }

  void setChangeWind(WindSpeed index) {
    decodedSetting.value.windSpeed = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
    decodedSetting.refresh();
  }

  void setChangePressure(Pressure index) {
    decodedSetting.value.pressure = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
    decodedSetting.refresh();
  }

  void setChangePrecipitataion(Precipitation index) {
    decodedSetting.value.precipitation = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
    decodedSetting.refresh();
  }

  void setChangeDistance(Distance index) {
    decodedSetting.value.distance = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
    decodedSetting.refresh();
  }

  void setChangeTimeFormat(Time index) {
    decodedSetting.value.timeFormat = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
    decodedSetting.refresh();
  }

  void setNewFavoriteLocation(Weather? weatherItem) {
    final checkDataFav = decodedFavoriteLocations;
    final RxList result = RxList();

    if (checkDataFav.isNotEmpty) {
      for (int index = 0; index < checkDataFav.length; index++) {
        result.add(checkDataFav[index]);
      }
    }
    result.add(json.encode(weatherItem));
    _getStorage.write(AppConstant.favoriteLocation, result);
    decodedFavoriteLocations.add(weatherItem);
  }

  void setDeleteFavorite() {
    final RxList dataFavorite = RxList();
    for (int i = 0; i < decodedFavoriteLocations.length; i++) {
      final a = jsonEncode(decodedFavoriteLocations[i]);
      dataFavorite.add(a);
    }
    _getStorage.write(AppConstant.favoriteLocation, dataFavorite);
    decodedFavoriteLocations.refresh();
  }
}
