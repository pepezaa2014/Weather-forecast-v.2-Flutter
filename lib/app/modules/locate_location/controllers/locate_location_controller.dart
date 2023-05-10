import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';

class LocateLocationController extends GetxController {
  final TextEditingController searchTextCityController =
      TextEditingController();

  final RxString searchCityText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchTextCityController.addListener(() {
      searchCityText.value = searchTextCityController.text;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goSetting() {
    Get.toNamed(Routes.SETTING);
  }
}
