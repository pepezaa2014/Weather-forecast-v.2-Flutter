import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class ShowDetailController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final WeatherAPI _weatherAPI = Get.find();
  late final Rxn<Weather> weather = Rxn();

  final FutureWeatherAPI _futureWeatherAPI = Get.find();
  late final Rxn<FutureWeather> futureWeather = Rxn();

  final AirPollutionAPI _airPollutionAPI = Get.find();
  late final Rxn<AirPollution> airPollution = Rxn();

  final Rxn<FavoriteLocations?> weather_info = Rxn();

  final isLoadingGetWeather = false.obs;

  DateTime now = DateTime.now();
  late final String formattedDate =
      DateFormat('dd MMMM yyyy HH:mm a').format(now);

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  final Rx<Temperature?> temperatureUnit = Temperature.celcius.obs;
  final Rx<WindSpeed?> windUnit = WindSpeed.mph.obs;
  final Rx<Pressure?> pressureUnit = Pressure.hpa.obs;
  final Rx<Precipitation?> precipitationUnit = Precipitation.mm.obs;
  final Rx<Distance?> distanceUnit = Distance.km.obs;
  final Rx<Time?> timeUnit = Time.h24.obs;
  final Rxn<Setting?> dataSetting = Rxn();

  final RxList<FavoriteLocations?> dataFavoriteLocations = RxList();

  @override
  void onInit() {
    super.onInit();
    dataSetting.value = _sessionManager.decodedSetting.value;
    weather_info.value = Get.arguments;

    _getWeatherLatLon(
      lat: weather_info.value?.lat ?? 0,
      lon: weather_info.value?.lon ?? 0,
    );

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
    final RxList<FavoriteLocations?> waitLocation = dataFavoriteLocations;
    waitLocation.add(
      FavoriteLocations.fromJson(
        {
          'lat': ((weather.value?.coord?.lat ?? 0.0)).toDouble(),
          'lon': ((weather.value?.coord?.lon ?? 0.0)).toDouble(),
        },
      ),
    );
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
