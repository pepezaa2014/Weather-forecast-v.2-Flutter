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

  final Rxn<Weather?> getWeatherInfo = Rxn();
  late final Rxn<AirPollution> airPollution = Rxn();
  late final Rxn<FutureWeather> futureWeather = Rxn();

  final isLoadingGetWeather = false.obs;

  final RxBool isInFav = false.obs;

  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  final Rxn<Setting?> dataSetting = Rxn();
  final RxList<Weather?> dataFavoriteLocations = RxList();

  @override
  void onInit() {
    super.onInit();
    isInFav.value = false;
    dataSetting.value = _sessionManager.decodedSetting.value;
    getWeatherInfo.value = Get.arguments;

    dataFavoriteLocations.value = _sessionManager.decodedFavoriteLocations;

    for (int index = 0; index < dataFavoriteLocations.length; index++) {
      if (dataFavoriteLocations[index]?.id == getWeatherInfo.value?.id) {
        isInFav.toggle();
      }
    }
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
      lat: getWeatherInfo.value?.coord?.lat ?? 0.0,
      lon: getWeatherInfo.value?.coord?.lon ?? 0.0,
    );
    await _getAirPollution(
      lat: getWeatherInfo.value?.coord?.lat ?? 0.0,
      lon: getWeatherInfo.value?.coord?.lon ?? 0.0,
    );
  }

  void addFavorite() {
    _sessionManager.setNewFavoriteLocation(
      getWeatherInfo.value,
    );

    Future.delayed(
      Duration.zero,
      () {
        Get.back();
      },
    );
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
