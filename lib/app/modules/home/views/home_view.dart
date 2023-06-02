import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/time.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
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
          backgroundColor: AppColors.backgroundColor,
          appBar: _appbar(),
          body: _body(),
        ),
        Obx(
          () => LoadingIndicator(
            isLoading: controller.isLoading.value,
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
        final currentLocation = controller.currentLocation.value;

        final dataFavoriteLocations = controller.dataFavoriteLocations.value;
        final allFutureWeather = controller.allFutureWeather.value;
        final allAirPollution = controller.allAirPollution.value;

        final setting = controller.dataSetting.value;
        final dataLength = dataFavoriteLocations.length;

        return Container(
          child: allFutureWeather.isEmpty &&
                  allAirPollution.isEmpty &&
                  dataFavoriteLocations.isEmpty &&
                  currentLocation == null
              ? const SizedBox()
              : Stack(
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      itemCount:
                          currentLocation != null ? dataLength + 1 : dataLength,
                      itemBuilder: (context, index) {
                        return _detail(
                          weatherData: currentLocation != null
                              ? index == 0
                                  ? currentLocation
                                  : dataFavoriteLocations[index - 1]
                              : dataFavoriteLocations[index],
                          futureWeatherData: currentLocation != null
                              ? index == 0
                                  ? allFutureWeather.firstWhereOrNull(
                                      (element) =>
                                          element.city?.id ==
                                          currentLocation.id)
                                  : allFutureWeather.firstWhereOrNull(
                                      (element) =>
                                          element.city?.id ==
                                          dataFavoriteLocations[index - 1].id)
                              : allFutureWeather.firstWhereOrNull((element) =>
                                  element.city?.id ==
                                  dataFavoriteLocations[index].id),
                          allAirPollution: currentLocation != null
                              ? index == 0
                                  ? allAirPollution.firstWhereOrNull(
                                      (element) =>
                                          element.coord?.lat ==
                                              currentLocation.coord?.lat &&
                                          element.coord?.lon ==
                                              currentLocation.coord?.lon)
                                  : allAirPollution.firstWhereOrNull(
                                      (element) =>
                                          element.coord?.lat ==
                                              dataFavoriteLocations[index - 1]
                                                  .coord
                                                  ?.lat &&
                                          element.coord?.lon ==
                                              dataFavoriteLocations[index - 1]
                                                  .coord
                                                  ?.lon)
                              : allAirPollution.firstWhereOrNull((element) =>
                                  element.coord?.lat ==
                                      dataFavoriteLocations[index].coord?.lat &&
                                  element.coord?.lon ==
                                      dataFavoriteLocations[index].coord?.lon),
                          setting: setting,
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
                            count: currentLocation != null
                                ? dataFavoriteLocations.length + 1
                                : dataFavoriteLocations.length,
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
    required Setting setting,
  }) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
