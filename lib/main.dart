import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:weather_v2_pepe/app/core/api/air_pollution_api.dart';
import 'package:weather_v2_pepe/app/core/api/future_weather_api.dart';
import 'package:weather_v2_pepe/app/core/api/geocoding_api.dart';
import 'package:weather_v2_pepe/app/core/api/weather_api.dart';
import 'package:weather_v2_pepe/app/core/dio_client.dart';
import 'package:weather_v2_pepe/app/managers/session_manager.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await _setupInstance();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      translationsKeys: AppTranslation.translations,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en'),
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: AppColors.appColor),
      ),
    ),
  );
}

Future<void> _setupInstance() async {
  await GetStorage.init();
  Get.put(GetStorage());

  final GetStorage getStorage = Get.find();
  Get.put(SessionManager(getStorage));

  Get.put(Dio());

  final Dio dio = Get.find();
  Get.put(
    DioClient(
      dio,
    ),
  );

  final DioClient dioClient = Get.find();
  Get.put(WeatherAPI(dioClient));
  Get.put(FutureWeatherAPI(dioClient));
  Get.put(AirPollutionAPI(dioClient));
  Get.put(GeocodingAPI(dioClient));
  return;
}
