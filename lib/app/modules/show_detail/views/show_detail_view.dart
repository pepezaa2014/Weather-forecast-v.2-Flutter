import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
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
                controller.getWeatherInfo.value?.name.toString() ?? '',
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
              child: controller.isInFav.value == true
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
          locationNow: controller.dataSetting.value?.timeFormat
              .convertTimeWithTimeZone(
                  (currentWeather?.dt ?? 0), (currentWeather?.timezone ?? 0)),
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
    );
  }
}
