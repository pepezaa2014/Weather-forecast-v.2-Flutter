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
import 'package:weather_v2_pepe/app/data/models/favorite_locations_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

class SessionManager {
  late final GetStorage _getStorage;

  SessionManager(this._getStorage);

  final Rxn<Weather> decodedCurrentLocation = Rxn();
  final Rxn<Weather> decodedAllWeather = Rxn();
  final RxList<FutureWeather?> decodedFuture = RxList(); // City Id
  final RxList<AirPollution?> decodedAirpollution = RxList(); // Lat,Lon

  final RxList<Weather?> decodedFavoriteLocations = RxList();

  final Rx<Setting> decodedSetting = Setting().obs;

  void loadSession() {
    _getStorage.remove(AppConstant.setting);
    _getStorage.remove(AppConstant.currentLocation);
    _getStorage.remove(AppConstant.favoriteLocation);
    _getStorage.remove(AppConstant.future);
    _getStorage.remove(AppConstant.airpollution);

    decodedCurrentLocation.value =
        _getStorage.read(AppConstant.currentLocation);

    decodedAllWeather.value = _getStorage.read(AppConstant.weather);

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
      final aItem = Weather.fromJson(
        {
          'name': 'Phayao',
        },
      );
      final aEncoded = json.encode(aItem.toJson());

      // final result = _getStorage.read(AppConstant.favoriteLocation);
      decodedFavoriteLocations.add(Weather.fromJson(jsonDecode(aEncoded)));
    }

    // decodedFuture.value = _getStorage.read(AppConstant.future);
    // decodedAirpollution.value = _getStorage.read(AppConstant.airpollution);
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

  void setNewFavoriteLocation(Weather? item) {
    final checkData = decodedFavoriteLocations;

    if (checkData != null) {
      checkData.add(item);
      _getStorage.write(AppConstant.favoriteLocation, checkData);
    } else {
      final RxList<Weather?> aItem = RxList();
      aItem.add(item);
      _getStorage.write(AppConstant.favoriteLocation, aItem);
    }
    decodedFavoriteLocations.refresh();
  }

  void setDeleteFavorite() {
    decodedFavoriteLocations.refresh();
    final RxList waittouse = RxList();
    for (int i = 0; i < decodedFavoriteLocations.length; i++) {
      final a = jsonEncode(decodedFavoriteLocations[i]);
      waittouse.add(a);
    }
    _getStorage.write(AppConstant.favoriteLocation, waittouse);
    decodedFavoriteLocations.refresh();
  }

  void setNewCurrentLocation(Weather? value) {
    _getStorage.write(AppConstant.currentLocation, value);
    decodedCurrentLocation.refresh();
  }

  void setAllWeather(Weather? value) {
    _getStorage.write(AppConstant.weather, value);
    decodedAllWeather.refresh();
  }
}
