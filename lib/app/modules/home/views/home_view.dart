import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
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
    return Stack(
      children: [
        PageView.builder(
          itemCount: controller.dataFavoriteLocations.length,
          itemBuilder: (context, index) {
            return Container(
              color: AppColors.backgroundColor,
              height: double.infinity,
              child: Obx(
                () {
                  final currentWeather = controller.weather;
                  final futureWeather = controller.futureWeather;
                  final airPollution = controller.airPollution;
                  if (controller.airPollution.isEmpty ||
                      controller.futureWeather.isEmpty ||
                      controller.weather.isEmpty) {
                    return Container(
                      color: AppColors.backgroundColor,
                    );
                  } else {
                    return _detail(
                      currentWeather: currentWeather[index],
                      futureWeather: futureWeather[index],
                      airPollution: airPollution[index],
                    );
                  }
                },
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SmoothPageIndicator(
                controller: PageController(
                  viewportFraction: 0.8,
                  keepPage: true,
                ),
                count: controller.dataFavoriteLocations.value.length,
                effect: const JumpingDotEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  jumpScale: .7,
                  dotColor: AppColors.primaryBox,
                ),
              ),
            ),
          ),
        ),
      ],
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
            unit: controller.temperatureUnit.value,
          ),
          FutureWeatherWidget(
            futureWeather: futureWeather,
            timeUnit: controller.timeUnit.value,
          ),
          Details(
            weather_info: currentWeather,
            pollution_info: airPollution,
            timeUnit: controller.timeUnit.value,
            windUnit: controller.windUnit.value,
            distanceUnit: controller.distanceUnit.value,
            pressureUnit: controller.pressureUnit.value,
            precipitationUnit: controller.precipitationUnit.value,
          ),
        ],
      ),
    );
  }
}
