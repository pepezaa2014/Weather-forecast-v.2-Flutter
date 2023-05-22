import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/data/models/favorite_locations_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';

class SessionManager {
  late final GetStorage _getStorage;

  SessionManager(this._getStorage);

  final Rxn<Setting?> decodedSetting = Rxn();
  final RxList<FavoriteLocations?> decodedFavoriteLocations = RxList();

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
    decodedSetting.value =
        Setting.fromJson(jsonDecode(_getStorage.read(AppConstant.setting)));

    // _getStorage.remove(AppConstant.favoriteLocation);
    if (_getStorage.read(AppConstant.favoriteLocation) == null) {
      final a = FavoriteLocations.fromJson(
        {
          'lat': 0.0,
          'lon': 0.0,
        },
      );
      final RxList<FavoriteLocations?> b = RxList();
      b.add(a);
      final bEncoded = json.encode(b.toJson());
      _getStorage.write(AppConstant.favoriteLocation, bEncoded);

      print(_getStorage.read(AppConstant.favoriteLocation));
      final c = jsonDecode(_getStorage.read(AppConstant.favoriteLocation));

      for (int i = 0; i < c.length; i++) {
        decodedFavoriteLocations.add(FavoriteLocations.fromJson(c[i]));
      }
    } else {
      print(_getStorage.read(AppConstant.favoriteLocation));
      final c = _getStorage.read(AppConstant.favoriteLocation);

      for (int i = 0; i < c.length; i++) {
        decodedFavoriteLocations
            .add(FavoriteLocations.fromJson(jsonDecode(c[i])));
      }
    }
  }

  void setChangeTemperature(int index) {
    decodedSetting.value?.temperature = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangeWind(int index) {
    decodedSetting.value?.windSpeed = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangePressure(int index) {
    decodedSetting.value?.pressure = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangePrecipitataion(int index) {
    decodedSetting.value?.precipitation = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangeDistance(int index) {
    decodedSetting.value?.distance = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setChangeTimeFormat(int index) {
    decodedSetting.value?.timeFormat = index;
    final dataEncoded = json.encode(decodedSetting);
    _getStorage.write(AppConstant.setting, dataEncoded);
  }

  void setYourLocation(RxList<FavoriteLocations?> item) {
    final RxList waittouse = RxList();
    for (int i = 0; i < item.length; i++) {
      final dataEncoded = json.encode(item[i]);
      waittouse.add(dataEncoded);
    }
    _getStorage.write(AppConstant.favoriteLocation, waittouse);
  }
}
