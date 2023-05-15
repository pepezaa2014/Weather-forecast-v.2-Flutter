import 'package:get/get.dart';

import '../controllers/show_detail_controller.dart';

class ShowDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowDetailController>(
      () => ShowDetailController(),
    );
  }
}
