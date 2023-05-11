import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';

class SessionManager {
  late final GetStorage _getStorage;

  SessionManager(this._getStorage);

  final RxList<String> favorites = RxList();

  void loadSession() {
    final result = _getStorage.read(AppConstant.favoriteCity);
    if (result is List) {
      favorites.value = result.whereType<String>().toList();
    }
  }

  void setFavoriteCity(String cityName) {
    if (favorites.value.contains(cityName)) {
      favorites.remove(cityName);
    } else {
      favorites.add(cityName);
    }
    _getStorage.write(AppConstant.favoriteCity, favorites.value);
  }
}
