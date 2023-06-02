import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.map_title.tr,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _map(),
            ),
            _button(),
          ],
        ),
      ),
    );
  }

  _map() {
    return Obx(
      () => GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (item) {
          controller.setMapController(item);
        },
        onCameraMove: (cameraPosition) {
          controller.setCenterLatLng(cameraPosition.target);
        },
        initialCameraPosition: CameraPosition(
          target: controller.centerLatLng.value,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("selectedLocation"),
            position: controller.centerLatLng.value,
          ),
        },
      ),
    );
  }

  _button() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          controller.goShowDetail();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppColors.thirdaryBox,
        ),
        child: Text(
          LocaleKeys.map_select.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNight,
          ),
        ),
      ),
    );
  }
}
