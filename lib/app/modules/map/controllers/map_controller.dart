import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';

class MapController extends GetxController {
  late final GoogleMapController mapController;
  late final latLon;
  late final Rx<LatLng> selectLatLon;
  late Marker marker;

  final centerLatLng = LatLng(0, 0).obs;

  @override
  void onInit() {
    super.onInit();
    latLon = Get.arguments;
    selectLatLon = Rx<LatLng>(LatLng(latLon['lat'], latLon['lon']));
    marker = Marker(markerId: MarkerId('default'));
    centerLatLng.value = LatLng(latLon['lat'], latLon['lon']);
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

  Map<String, double> convertLatLon() {
    return {
      'lat': centerLatLng.value.latitude,
      'lon': centerLatLng.value.longitude,
    };
  }

  void goShowDetail(Map<String, dynamic> item) {
    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    );
  }
}
