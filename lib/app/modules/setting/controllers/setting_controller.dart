import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';

class SettingController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  // late final RxInt temperatureUnit;
  // late final RxInt windUnit;
  // late final RxInt pressureUnit;
  // late final RxInt precipitationUnit;
  // late final RxInt distanceUnit;
  // late final RxInt timeUnit;

  late final Setting? setting;

  @override
  void onInit() {
    super.onInit();

    final wait = {
      {'temperature': _sessionManager.temperature},
      {'windSpeed': _sessionManager.wind},
      {'pressure': _sessionManager.pressure},
      {'precipitation': _sessionManager.precipitataion},
      {'distance': _sessionManager.distance},
      {'timeFormat': _sessionManager.timeFormat},
    };
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeSetting(Set<Map<String, int>> item) {
    _sessionManager.setSetting(item);
  }
}
