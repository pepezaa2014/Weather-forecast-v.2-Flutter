import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/utils/loading_indicator.dart';
import 'package:weather_v2_pepe/app/widgets/details.dart';
import 'package:weather_v2_pepe/app/widgets/future_weather_widget.dart';
import 'package:weather_v2_pepe/app/widgets/top_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _appbar(),
          body: _body(),
        ),
        Obx(
          () =>
              LoadingIndicator(isLoading: controller.isLoadingGetWeather.value),
        ),
      ],
    );
  }

  _appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Weather',
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: controller.goLocate,
          icon: const Icon(
            Icons.list,
          ),
        ),
      ],
    );
  }

  _body() {
    return PageView.builder(
      itemCount: controller.favoriteLocation.value.length,
      itemBuilder: (context, index) {
        return Container(
          color: AppColors.backgroundColor,
          height: double.infinity,
          child: Obx(
            () {
              final currentWeather = controller.weather.value;
              final futureWeather = controller.futureWeather.value;
              final airPollution = controller.airPollution.value;
              if (controller.airPollution.value == null ||
                  controller.futureWeather.value == null ||
                  controller.weather.value == null) {
                return Container(
                  color: AppColors.backgroundColor,
                );
              } else {
                return _detail(
                  currentWeather: currentWeather,
                  futureWeather: futureWeather,
                  airPollution: airPollution,
                );
              }
            },
          ),
        );
      },
    );
  }

  _detail({
    required Weather? currentWeather,
    required FutureWeather? futureWeather,
    required AirPollution? airPollution,
  }) {
    return Container(
      child: Column(
        children: [
          TopView(
            weather_info: currentWeather,
            location_now: 'Current Location',
            unit: Temperature.values.firstWhereOrNull(
                (e) => e.keyValue == controller.temperatureUnit.value),
          ),
          FutureWeatherWidget(
            futureWeather: futureWeather,
            timeUnit: Time.values.firstWhereOrNull(
                (e) => e.keyValue == controller.timeUnit.value),
          ),
          Details(
            weather_info: currentWeather,
            pollution_info: airPollution,
            timeUnit: Time.values.firstWhereOrNull(
                (e) => e.keyValue == controller.timeUnit.value),
            windUnit: WindSpeed.values.firstWhereOrNull(
                (e) => e.keyValue == controller.windUnit.value),
            distanceUnit: Distance.values.firstWhereOrNull(
                (e) => e.keyValue == controller.distanceUnit.value),
            pressureUnit: Pressure.values.firstWhereOrNull(
                (e) => e.keyValue == controller.pressureUnit.value),
            precipitationUnit: Precipitation.values.firstWhereOrNull(
                (e) => e.keyValue == controller.precipitationUnit.value),
          ),
        ],
      ),
    );
  }
}


// SmoothPageIndicator(
//                       controller: PageController(
//                         viewportFraction: 0.8,
//                         keepPage: true,
//                       ),
//                       count: controller.favoriteLocation.value.length,
//                       effect: const JumpingDotEffect(
//                         dotHeight: 16,
//                         dotWidth: 16,
//                         jumpScale: .7,
//                         dotColor: AppColors.primaryBox,
//                       ),
//                     ),