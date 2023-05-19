import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class ShowDetailController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final WeatherAPI _weatherAPI = Get.find();
  late final Rxn<Weather> weather = Rxn();

  final FutureWeatherAPI _futureWeatherAPI = Get.find();
  late final Rxn<FutureWeather> futureWeather = Rxn();

  final AirPollutionAPI _airPollutionAPI = Get.find();
  late final Rxn<AirPollution> airPollution = Rxn();

  late final Map<String, dynamic> weather_info;

  final isLoadingGetWeather = false.obs;

  DateTime now = DateTime.now();
  late final String formattedDate =
      DateFormat('dd MMMM yyyy HH:mm a').format(now);

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  late final RxInt temperatureUnit;
  late final RxInt windUnit;
  late final RxInt pressureUnit;
  late final RxInt precipitationUnit;
  late final RxInt distanceUnit;
  late final RxInt timeUnit;
  late final RxList<Map<String, double>> favoriteLocation;

  @override
  void onInit() {
    super.onInit();
    weather_info = Get.arguments;

    _getWeatherLatLon(
      lat: weather_info['lat'],
      lon: weather_info['lon'],
    );

    temperatureUnit = _sessionManager.temperature;
    windUnit = _sessionManager.wind;
    pressureUnit = _sessionManager.pressure;
    precipitationUnit = _sessionManager.precipitataion;
    distanceUnit = _sessionManager.distance;
    timeUnit = _sessionManager.timeFormat;
    favoriteLocation = _sessionManager.favoriteLocation;
  }

  @override
  void onReady() {
    super.onReady();
    // weather.value = weather_info;

    _getFutureWeather(
      lat: weather.value?.coord?.lat ?? 0.0,
      lon: weather.value?.coord?.lon ?? 0.0,
    );
    _getAirPollution(
      lat: weather.value?.coord?.lat ?? 0.0,
      lon: weather.value?.coord?.lon ?? 0.0,
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addFavorite() {
    final RxList<Map<String, double>> waitLocation = favoriteLocation;
    print(waitLocation);

    waitLocation.add(
      {
        'lat': ((weather.value?.coord?.lat ?? 0.0)).toDouble(),
        'lon': ((weather.value?.coord?.lon ?? 0.0)).toDouble(),
      },
    );
    print(waitLocation);

    _sessionManager.setYourLocation(waitLocation);

    Future.delayed(
      Duration.zero,
      () {
        Get.back();
      },
    );
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
