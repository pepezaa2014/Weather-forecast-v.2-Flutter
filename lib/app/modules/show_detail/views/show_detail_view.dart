import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';
import 'package:weather_v2_pepe/app/utils/loading_indicator.dart';
import 'package:weather_v2_pepe/app/widgets/details.dart';
import 'package:weather_v2_pepe/app/widgets/future_weather_widget.dart';
import 'package:weather_v2_pepe/app/widgets/top_view.dart';

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
          () => loadingIndicator(controller.isLoading.value),
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
              return Text(
                controller.weather.value?.name.toString() ?? '',
              );
            },
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: controller.addFavorite,
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }

  _body() {
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
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  TopView(
                    weather_info: currentWeather,
                    location_now: controller.formattedDate,
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
                        (e) =>
                            e.keyValue == controller.precipitationUnit.value),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
