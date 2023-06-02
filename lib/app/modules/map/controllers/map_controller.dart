import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/data/models/app_error_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/app/utils/show_alert.dart';

class MapController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  late final GoogleMapController mapController;
  final WeatherAPI _weatherAPI = Get.find();

  late final Rxn<Weather> currentLocation;
  final Rxn<Weather?> weather = Rxn();
  late final Rx<LatLng> selectLatLon;

  final centerLatLng = LatLng(0, 0).obs;

  @override
  void onInit() {
    super.onInit();
    currentLocation = _sessionManager.currentLocation;

    selectLatLon = Rx<LatLng>(LatLng(currentLocation.value?.coord?.lat ?? 0,
        currentLocation.value?.coord?.lon ?? 0));

    centerLatLng.value = LatLng(
      currentLocation.value?.coord?.lat ?? 0,
      currentLocation.value?.coord?.lon ?? 0,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void setCenterLatLng(LatLng latLng) {
    centerLatLng.value = latLng;
  }

  Future<void> _getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _weatherAPI.getWeatherLatLon(
        lat: lat,
        lon: lon,
      );
      weather.value = result;
    } catch (error) {
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
    return null;
  }

  Future<void> goShowDetail() async {
    await _getWeatherLatLon(
      lat: centerLatLng.value.latitude,
      lon: centerLatLng.value.longitude,
    );

    Get.toNamed(Routes.SHOW_DETAIL, arguments: weather.value);
  }
}
