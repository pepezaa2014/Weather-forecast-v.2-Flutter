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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Obx(
              () => GoogleMap(
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
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 48),
            child: Center(
              child: Icon(
                Icons.location_on,
                color: AppColors.marker,
                size: 56,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
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
          ),
        ],
      ),
    );
  }
}
