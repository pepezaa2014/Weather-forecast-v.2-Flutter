import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';

import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
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

  late final Rxn<Weather> weather = Rxn();
  late final Rxn<FutureWeather> futureWeather = Rxn();
  late final Rxn<AirPollution> airPollution = Rxn();

  final RxInt temperatureUnit = 0.obs;
  final RxInt windUnit = 0.obs;
  final RxInt pressureUnit = 0.obs;
  final RxInt precipitationUnit = 0.obs;
  final RxInt distanceUnit = 0.obs;
  final RxInt timeUnit = 0.obs;
  final Rxn<Setting?> dataSetting = Rxn();

  late final RxList<Map<String, dynamic>> favoriteLocation;

  final isLoadingGetWeather = false.obs;

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
    dataSetting.value = _sessionManager.decoded.value;
    // print('Start Now');
    // print('=================================');
    // _sessionManager.printText();
    // print('This is controller');
    // print('=================================');
    // print(dataSetting.value);
    // print(dataSetting.value?.temperature);

    temperatureUnit.value = dataSetting.value?.temperature ?? 0;
    windUnit.value = dataSetting.value?.windSpeed ?? 0;
    pressureUnit.value = dataSetting.value?.pressure ?? 0;
    precipitationUnit.value = dataSetting.value?.precipitation ?? 0;
    distanceUnit.value = dataSetting.value?.distance ?? 0;
    timeUnit.value = dataSetting.value?.timeFormat ?? 0;
    favoriteLocation = _sessionManager.favoriteLocation;
    print(_sessionManager.favoriteLocation);
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

    if (_sessionManager.favoriteLocation[0]['lat'] == 0 &&
        _sessionManager.favoriteLocation[0]['lon'] == 0) {
      final waitToReplace = _sessionManager.favoriteLocation;
      waitToReplace[0] = {
        'lat': location.latitude,
        'lon': location.longitude,
      };
      _sessionManager.setYourLocation(waitToReplace);
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
      weather.value = result;
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
      futureWeather.value = result;
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
      airPollution.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }
}
