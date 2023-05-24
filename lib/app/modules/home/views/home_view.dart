import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
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
          () => LoadingIndicator(
            isLoading: controller.isLoadingGetWeather.value,
          ),
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
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: Obx(
        () {
          final currentWeather = controller.weather;
          final futureWeather = controller.futureWeather;
          final airPollution = controller.airPollution;

          return Container(
            child: airPollution.length !=
                    controller.dataFavoriteLocations.length
                ? Container(
                    color: AppColors.backgroundColor,
                  )
                : Stack(
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.dataFavoriteLocations.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: AppColors.backgroundColor,
                            height: double.infinity,
                            child: _detail(
                              currentWeather: currentWeather[index],
                              futureWeather: futureWeather[index],
                              airPollution: airPollution[index],
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
                              controller: controller.pageController,
                              count: controller.dataFavoriteLocations.length,
                              effect: const WormEffect(
                                dotHeight: 16,
                                dotWidth: 16,
                                dotColor: AppColors.primaryBox,
                                activeDotColor: AppColors.dotColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  _detail({
    required Weather? currentWeather,
    required FutureWeather? futureWeather,
    required AirPollution? airPollution,
  }) {
    final setting = controller.dataSetting.value;

    return Column(
      children: [
        TopView(
          weatherInfo: currentWeather,
          locationNow: (currentWeather == controller.weather[0])
              ? 'Current Location'
              : controller.dataSetting.value?.timeFormat
                  ?.convertTimeWithTimeZone(
                      (currentWeather?.dt ?? 0), currentWeather?.timezone ?? 0),
          unit: controller.dataSetting.value?.temperature,
        ),
        FutureWeatherWidget(
          futureWeather: futureWeather,
          timeUnit: controller.dataSetting.value?.timeFormat,
        ),
        Details(
          weatherInfo: currentWeather,
          pollutionInfo: airPollution,
          timeUnit: setting?.timeFormat,
          windUnit: setting?.windSpeed,
          distanceUnit: setting?.distance,
          pressureUnit: setting?.pressure,
          precipitationUnit: setting?.precipitation,
        ),
      ],
    );
  }
}
