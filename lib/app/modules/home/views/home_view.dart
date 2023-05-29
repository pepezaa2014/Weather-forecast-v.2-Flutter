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
import 'package:weather_v2_pepe/generated/locales.g.dart';

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
      title: Text(
        LocaleKeys.home_title.tr,
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
    return Obx(
      () {
        final allDataWeather = controller.allWeatherData.value;

        final getAllWeather = controller.getAllWeather.value;
        final allFutureWeather = controller.allFutureWeather.value;
        final allAirPollution = controller.allAirPollution.value;

        return Container(
          child: getAllWeather.isEmpty &&
                  allFutureWeather.isEmpty &&
                  allAirPollution.isEmpty &&
                  allDataWeather.isEmpty
              ? Container(
                  color: AppColors.backgroundColor,
                )
              : Stack(
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      itemCount: allDataWeather.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: AppColors.backgroundColor,
                          height: double.infinity,
                          child: _detail(
                            weatherData: getAllWeather.firstWhereOrNull(
                                (element) =>
                                    element?.id == allDataWeather[index]?.id),
                            futureWeatherData:
                                allFutureWeather.firstWhereOrNull((element) =>
                                    element?.city?.id ==
                                    allDataWeather[index]?.id),
                            allAirPollution: allAirPollution.firstWhereOrNull(
                                (element) =>
                                    element?.coord?.lat ==
                                        allDataWeather[index]?.coord?.lat &&
                                    element?.coord?.lon ==
                                        allDataWeather[index]?.coord?.lon),
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
                              dotColor: AppColors.dotColor,
                              activeDotColor: AppColors.activeDotColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  _detail({
    required Weather? weatherData,
    required FutureWeather? futureWeatherData,
    required AirPollution? allAirPollution,
  }) {
    final setting = controller.dataSetting.value;

    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            TopView(
              weatherInfo: weatherData,
              locationNow:
                  controller.currentLocation.value?.id == weatherData?.id
                      ? LocaleKeys.home_location.tr
                      : setting.timeFormat.convertTimeWithTimeZone(
                          (weatherData?.dt ?? 0), weatherData?.timezone ?? 0),
              setting: setting,
            ),
            FutureWeatherWidget(
              futureWeather: futureWeatherData,
              setting: setting,
            ),
            Details(
              weatherInfo: weatherData,
              pollutionInfo: allAirPollution,
              setting: setting,
            ),
          ],
        ),
      ),
    );
  }
}
