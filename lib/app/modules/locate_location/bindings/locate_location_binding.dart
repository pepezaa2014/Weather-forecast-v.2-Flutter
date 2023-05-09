import 'package:get/get.dart';

import '../controllers/locate_location_controller.dart';

class LocateLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocateLocationController>(
      () => LocateLocationController(),
    );
  }
}
