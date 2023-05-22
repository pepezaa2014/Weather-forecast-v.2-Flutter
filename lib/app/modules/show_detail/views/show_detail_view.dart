import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
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
          () => LoadingIndicator(
            isLoading: controller.isLoadingGetWeather.value,
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
              return Text(
                controller.weather.value?.name.toString() ?? '',
              );
            },
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Obx(
          () {
            return Container(
              child: controller.dataFavoriteLocations.any((e) =>
                      e?.lat == controller.weather_info.value?.lat &&
                      e?.lon == controller.weather_info.value?.lon)
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
    return Container(
      color: AppColors.backgroundColor,
      height: double.infinity,
      child: Obx(
        () {
          final currentWeather = controller.weather;
          final futureWeather = controller.futureWeather;
          final airPollution = controller.airPollution;
          if (controller.airPollution == null ||
              controller.futureWeather == null ||
              controller.weather == null) {
            return Container(
              color: AppColors.backgroundColor,
            );
          } else {
            return _detail(
              currentWeather: currentWeather.value,
              futureWeather: futureWeather.value,
              airPollution: airPollution.value,
            );
          }
        },
      ),
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
