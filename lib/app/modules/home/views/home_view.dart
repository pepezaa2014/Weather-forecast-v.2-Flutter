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
          final allDataWeather = controller.allWeatherData;
          final allFutureWeather = controller.allFutureWeather;
          final allAirPollution = controller.allAirPollution;

          return Container(
            child: allDataWeather.isEmpty
                ? Container(
                    color: AppColors.backgroundColor,
                  )
                : Stack(
                    // child: Stack(
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.allWeatherData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: AppColors.backgroundColor,
                            height: double.infinity,
                            child: _detail(
                              allDataWeather: allDataWeather[index],
                              // allFutureWeather: allFutureWeather[index],
                              // allAirPollution: allAirPollution[index],
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
                              count: allDataWeather.length,
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
    required Weather? allDataWeather,
    // required FutureWeather? allFutureWeather,
    // required AirPollution? allAirPollution,
  }) {
    final setting = controller.dataSetting.value;

    return Column(
      children: [
        TopView(
          weatherInfo: allDataWeather,
          locationNow: controller.currentLocation != null
              ? 'Current Location'
              : setting.timeFormat.convertTimeWithTimeZone(
                  (allDataWeather?.dt ?? 0), allDataWeather?.timezone ?? 0),
          setting: setting,
        ),
        // FutureWeatherWidget(
        //   futureWeather: allFutureWeather,
        //   setting: setting,
        // ),
        // Details(
        //   weatherInfo: allDataWeather,
        //   pollutionInfo: allAirPollution,
        //   setting: setting,
        // ),
      ],
    );
  }
}
