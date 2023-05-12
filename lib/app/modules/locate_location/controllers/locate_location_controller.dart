import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/core/api/geocoding_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/extensions/bool_extension.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class LocateLocationController extends GetxController {
  final TextEditingController searchTextCityController =
      TextEditingController();

  final RxString searchCityText = ''.obs;
  final WeatherAPI _weatherAPI = Get.find();
  final GeocodingAPI _geocodingAPI = Get.find();

  late final Rxn<Weather> weather = Rxn();
  late final Rxn<Geocoding> geocoding = Rxn();

  final isLoadingGetWeather = false.obs;
  RxBool get isLoading {
    return [
      isLoadingGetWeather.value,
    ].atLeastOneTrue.obs;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    searchTextCityController.addListener(
      () {
        searchCityText.value = searchTextCityController.text;
        // if (searchCityText.value != '') {
        //   _getGeocoding(
        //     city: searchCityText.value,
        //   );
        // }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goSetting() {
    Get.toNamed(Routes.SETTING);
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

  void _getGeocoding({
    required String city,
  }) async {
    try {
      isLoadingGetWeather(true);
      final result = await _geocodingAPI.getWeatherCity(
        city: city,
      );
      isLoadingGetWeather(false);
      geocoding.value = result;
    } catch (error) {
      isLoadingGetWeather(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  void clickToGeo() {
    _getGeocoding(
      city: searchCityText.value,
    );
  }
}
