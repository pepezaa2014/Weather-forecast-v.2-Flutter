import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/time.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/utils/loading_indicator.dart';
import 'package:weather_v2_pepe/app/widgets/details.dart';
import 'package:weather_v2_pepe/app/widgets/future_weather_widget.dart';
import 'package:weather_v2_pepe/app/widgets/top_view.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';

import '../controllers/show_detail_controller.dart';

class ShowDetailView extends GetView<ShowDetailController> {
  const ShowDetailView({Key? key}) : super(key: key);
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
            isLoading: controller.isLoading.value,
          ),
        ),
      ],
    );
  }

  _appbar() {
    return AppBar(
      title: Column(
        children: [
          Obx(
            () {
              final wetherInfo = controller.getWeatherInfo.value;
              return Text(
                wetherInfo.name.toString(),
              );
            },
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Obx(
          () {
            final wetherInfo = controller.getWeatherInfo.value;
            return Container(
              child: wetherInfo.id == controller.currentLocation.value?.id ||
                      controller.dataFavoriteLocations
                          .any((element) => element.id == wetherInfo.id)
                  ? const SizedBox()
                  : IconButton(
                      onPressed: controller.addFavorite,
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }

  _body() {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: Container(
        color: AppColors.backgroundColor,
        height: double.infinity,
        child: Obx(
          () {
            final currentWeather = controller.getWeatherInfo;
            final futureWeather = controller.futureWeather;
            final airPollution = controller.airPollution;
            return _detail(
              currentWeather: currentWeather.value,
              futureWeather: futureWeather.value,
              airPollution: airPollution.value,
            );
          },
        ),
      ),
    );
  }

  _detail({
    required Weather? currentWeather,
    required FutureWeather? futureWeather,
    required AirPollution? airPollution,
  }) {
    final setting = controller.dataSetting.value;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          TopView(
            weatherInfo: currentWeather,
            locationNow: controller.currentLocation.value?.id ==
                    currentWeather?.id
                ? LocaleKeys.home_location.tr
                : setting.timeFormat.currentTime(
                    (currentWeather?.dt ?? 0), currentWeather?.timezone ?? 0),
            setting: setting,
          ),
          FutureWeatherWidget(
            futureWeather: futureWeather,
            setting: setting,
          ),
          Details(
            weatherInfo: currentWeather,
            pollutionInfo: airPollution,
            setting: setting,
          ),
        ],
      ),
    );
  }
}
