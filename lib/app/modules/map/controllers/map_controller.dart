import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_v2_pepe/app/data/models/favorite_locations_model.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';

class MapController extends GetxController {
  late final GoogleMapController mapController;
  final Rxn<FavoriteLocations>? latLon = Rxn();
  late final Rx<LatLng> selectLatLon;

  final centerLatLng = LatLng(0, 0).obs;

  @override
  void onInit() {
    super.onInit();
    latLon?.value = Get.arguments;
    selectLatLon =
        Rx<LatLng>(LatLng(latLon?.value?.lat ?? 0, latLon?.value?.lon ?? 0));
    centerLatLng.value =
        LatLng(latLon?.value?.lat ?? 0, latLon?.value?.lon ?? 0);
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

  FavoriteLocations? convertLatLon() {
    return FavoriteLocations.fromJson({
      'lat': centerLatLng.value.latitude,
      'lon': centerLatLng.value.longitude,
    });
  }

  void goShowDetail(FavoriteLocations? item) {
    Get.toNamed(
      Routes.SHOW_DETAIL,
      arguments: item,
    );
  }
}
