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
        _getStorage.write(AppConstant.keyValueSetting, unitSettingsString);
      },
    );

    dataFavoriteLocations.listen(
      (p0) {
        final weatherListString =
            p0.map((e) => json.encode(e.toJson())).toList();
        _getStorage.write(
            AppConstant.keyValueFavoriteLocation, weatherListString);
      },
    );
  }

  void loadSession() {
    _getStorage.remove(AppConstant.keyValueSetting);
    _getStorage.remove(AppConstant.keyValueFavoriteLocation);

    var checkedSetting = _getStorage.read(AppConstant.keyValueSetting);
    if (checkedSetting != null) {
      dataSetting.value = Setting.fromJson(jsonDecode(checkedSetting));
    }

    final checkedFavorite =
        _getStorage.read(AppConstant.keyValueFavoriteLocation);
    if (checkedFavorite != null) {
      for (int i = 0; i < checkedFavorite.length; i++) {
        dataFavoriteLocations
            .add(Weather.fromJson(jsonDecode(checkedFavorite[i])));
      }
    } else {
      final RxList<Weather?> result = RxList();
      _getStorage.write(AppConstant.keyValueFavoriteLocation, result);
      dataFavoriteLocations.refresh();
    }
  }

  void setChangeTemperature(Temperature index) {
    final dataEncoded = json.encode(dataSetting);
    _getStorage.write(AppConstant.keyValueSetting, dataEncoded);
    dataSetting.refresh();
  }

  void setChangeWind(WindSpeed index) {
    final dataEncoded = json.encode(dataSetting);
    _getStorage.write(AppConstant.keyValueSetting, dataEncoded);
    dataSetting.refresh();
  }

  void setChangePressure(Pressure index) {
    final dataEncoded = json.encode(dataSetting);
    _getStorage.write(AppConstant.keyValueSetting, dataEncoded);
    dataSetting.refresh();
  }

  void setChangePrecipitataion(Precipitation index) {
    final dataEncoded = json.encode(dataSetting);
    _getStorage.write(AppConstant.keyValueSetting, dataEncoded);
    dataSetting.refresh();
  }

  void setChangeDistance(Distance index) {
    final dataEncoded = json.encode(dataSetting);
    _getStorage.write(AppConstant.keyValueSetting, dataEncoded);
    dataSetting.refresh();
  }

  void setChangeTimeFormat(Time index) {
    final dataEncoded = json.encode(dataSetting);
    _getStorage.write(AppConstant.keyValueSetting, dataEncoded);
    dataSetting.refresh();
  }

  void setNewFavoriteLocation(Weather weatherItem) {
    final checkDataFav = dataFavoriteLocations;
    final RxList result = RxList();

    if (checkDataFav.isNotEmpty) {
      for (int index = 0; index < checkDataFav.length; index++) {
        result.add(checkDataFav[index]);
      }
    }
    result.add(json.encode(weatherItem));
    _getStorage.write(AppConstant.keyValueFavoriteLocation, result);
    dataFavoriteLocations.refresh();
  }

  void setDeleteFavorite() {
    final RxList dataFavorite = RxList();
    for (int i = 0; i < dataFavoriteLocations.length; i++) {
      final a = jsonEncode(dataFavoriteLocations[i]);
      dataFavorite.add(a);
    }
    _getStorage.write(AppConstant.keyValueFavoriteLocation, dataFavorite);
    dataFavoriteLocations.refresh();
  }
}
