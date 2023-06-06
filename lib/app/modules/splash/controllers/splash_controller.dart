import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/app/routes/app_pages.dart';
import 'package:weather_v2_pepe/resources/resources.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  final SessionManager _sessionManager = Get.find();
  final logoName = ImageName.weather04n;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _sessionManager.active.value = true;
    } else if (state == AppLifecycleState.paused) {
      _sessionManager.active.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    _goFirstScreen();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _goFirstScreen() {
    Get.updateLocale(const Locale('th'));
    initializeDateFormatting(Get.locale?.languageCode);

    _sessionManager.loadSession();

    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _sessionManager.timerData.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }
}
