import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/locate_location/bindings/locate_location_binding.dart';
import '../modules/locate_location/views/locate_location_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/show_detail/bindings/show_detail_binding.dart';
import '../modules/show_detail/views/show_detail_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.LOCATE_LOCATION,
      page: () => const LocateLocationView(),
      binding: LocateLocationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SHOW_DETAIL,
      page: () => const ShowDetailView(),
      binding: ShowDetailBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
