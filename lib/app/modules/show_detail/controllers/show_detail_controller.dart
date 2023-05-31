import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class ShowDetailController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final FutureWeatherAPI _futureWeatherAPI = Get.find();
  final AirPollutionAPI _airPollutionAPI = Get.find();

  final Rx<Weather> getWeatherInfo = Rx<Weather>(Weather());
  final Rx<AirPollution> airPollution = Rx<AirPollution>(AirPollution());
  final Rx<FutureWeather> futureWeather = Rx<FutureWeather>(FutureWeather());

  late final Rx<Weather> currentLocation;
  late final Rx<Setting> dataSetting;
  late final RxList<Weather> dataFavoriteLocations;
  late final RxList<FutureWeather> allFutureWeather;
  late final RxList<AirPollution> allAirpollution;

  late final RxList<Weather> allweatherData;

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
    getWeatherInfo.value = Get.arguments;

    currentLocation = _sessionManager.currentLocation;
    dataSetting = _sessionManager.dataSetting;
    dataFavoriteLocations = _sessionManager.dataFavoriteLocations;

    allweatherData = _sessionManager.allWeatherData;
    allFutureWeather = _sessionManager.allFutureWeather;
    allAirpollution = _sessionManager.allAirPollution;
  }

  @override
  void onReady() {
    super.onReady();
    _getLoadingAllData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _getLoadingAllData() async {
    await _getFutureWeather(
      lat: getWeatherInfo.value.coord?.lat ?? 0.0,
      lon: getWeatherInfo.value.coord?.lon ?? 0.0,
    );
    await _getAirPollution(
      lat: getWeatherInfo.value.coord?.lat ?? 0.0,
      lon: getWeatherInfo.value.coord?.lon ?? 0.0,
    );
  }

  void addFavorite() {
    dataFavoriteLocations.add(getWeatherInfo.value);
    allweatherData.add(getWeatherInfo.value);
    allFutureWeather.add(futureWeather.value);
    allAirpollution.add(airPollution.value);

    Get.back();
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
      futureWeather.value = result;
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
