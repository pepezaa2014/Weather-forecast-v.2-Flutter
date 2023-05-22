import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';

import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/favorite_locations_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class HomeController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final WeatherAPI _weatherAPI = Get.find();
  final FutureWeatherAPI _futureWeatherAPI = Get.find();
  final AirPollutionAPI _airPollutionAPI = Get.find();

  late final RxList<Weather> weather = RxList();
  late final RxList<FutureWeather> futureWeather = RxList();
  late final RxList<AirPollution> airPollution = RxList();

  final Rx<Temperature?> temperatureUnit = Temperature.celcius.obs;
  final Rx<WindSpeed?> windUnit = WindSpeed.mph.obs;
  final Rx<Pressure?> pressureUnit = Pressure.hpa.obs;
  final Rx<Precipitation?> precipitationUnit = Precipitation.mm.obs;
  final Rx<Distance?> distanceUnit = Distance.km.obs;
  final Rx<Time?> timeUnit = Time.h24.obs;
  final Rxn<Setting?> dataSetting = Rxn();

  final RxList<FavoriteLocations?> dataFavoriteLocations = RxList();

  final isLoadingGetWeather = false.obs;

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
    dataSetting.value = _sessionManager.decodedSetting.value;

    temperatureUnit.value = dataSetting.value?.temperatureData;
    windUnit.value = dataSetting.value?.windSpeedData;
    pressureUnit.value = dataSetting.value?.pressureData;
    precipitationUnit.value = dataSetting.value?.precipitationData;
    distanceUnit.value = dataSetting.value?.distanceData;
    timeUnit.value = dataSetting.value?.timeData;

    dataFavoriteLocations.value = _sessionManager.decodedFavoriteLocations;
  }

  @override
  void onReady() {
    super.onReady();
    _determinePosition();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goLocate() {
    Get.toNamed(Routes.LOCATE_LOCATION);
  }

  @override
  Future<void> refresh() async {
    _determinePosition();
  }

  void _determinePosition() async {
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
    _getWeatherLatLon(
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

    if (dataFavoriteLocations[0]?.lat == 0 &&
        dataFavoriteLocations[0]?.lon == 0) {
      dataFavoriteLocations[0]?.lat = location.latitude;
      dataFavoriteLocations[0]?.lon = location.longitude;

      _sessionManager.setYourLocation(dataFavoriteLocations);
    }
  }

  void _getWeatherLatLon({
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
      weather.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  void _getFutureWeather({
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
      futureWeather.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  void _getAirPollution({
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
      airPollution.add(result);
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
