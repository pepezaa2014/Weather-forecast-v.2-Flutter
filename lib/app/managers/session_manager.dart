import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_constants.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';

import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class SessionManager {
  late final GetStorage _getStorage;

  final WeatherAPI _weatherAPI = Get.find();
  final FutureWeatherAPI _futureWeatherAPI = Get.find();
  final AirPollutionAPI _airPollutionAPI = Get.find();

  final Rx<Setting> dataSetting = Setting().obs;

  final Rxn<Weather> currentLocation = Rxn();

  final RxList<Weather> dataFavoriteLocations = RxList();
  final RxList<FutureWeather> allFutureWeather = RxList();
  final RxList<AirPollution> allAirPollution = RxList();

  final RxBool tick = false.obs;
  late final Timer timerData;
  final RxBool active = true.obs;

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

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

    _timerGetData();
  }

  void loadSession() {
    final checkedSetting = _getStorage.read(AppConstants.keyValueSetting);
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

  void _timerGetData() {
    timerData = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        if (active.value) {
          tick.toggle();
        }
      },
    );
  }

  Future<void> _getCurrentWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);
      currentLocation.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);

      int index = dataFavoriteLocations
          .indexWhere((element) => element.id == result.id);

      if (index != -1) {
        dataFavoriteLocations.value[index] = result;
        dataFavoriteLocations.refresh();
      }
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getFutureWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _futureWeatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);
      allFutureWeather.add(result);
      allFutureWeather.refresh();
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _getAirPollution({
    required double lat,
    required double lon,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _airPollutionAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      isLoadingGetWeather(false);
      allAirPollution.add(result);
      allAirPollution.refresh();
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlert(
        title: 'Error',
        message: 'Location services are disabled.',
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlert(
          title: 'Error',
          message: 'Location permissions are denied',
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlert(
        title: 'Error',
        message:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final location = await Geolocator.getCurrentPosition();

    _getCurrentWeatherLatLon(
      lat: location.latitude,
      lon: location.longitude,
    );

    _getFutureWeather(
      lat: location.latitude,
      lon: location.longitude,
    );

    _getAirPollution(
      lat: location.latitude,
      lon: location.longitude,
    );
  }

  void updateWeather() {
    allFutureWeather.clear();
    allAirPollution.clear();

    _determinePosition();

    dataFavoriteLocations.forEach((element) {
      _getWeatherLatLon(
        lat: element.coord?.lat ?? 0.0,
        lon: element.coord?.lon ?? 0.0,
      );
      _getFutureWeather(
        lat: element.coord?.lat ?? 0.0,
        lon: element.coord?.lon ?? 0.0,
      );
      _getAirPollution(
        lat: element.coord?.lat ?? 0.0,
        lon: element.coord?.lon ?? 0.0,
      );
    });
  }
}
