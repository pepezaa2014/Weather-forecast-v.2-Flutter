import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
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
          () => loadingIndicator(controller.isLoading.value),
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
      onRefresh: _refresh,
      child: Container(
        color: AppColors.backgroundColor,
        child: Obx(
          () {
            final currentWeather = controller.weather.value;
            final futureWeather = controller.futureWeather.value;
            final airPollution = controller.airPollution.value;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  TopView(
                    weather_info: currentWeather,
                    location_now: 'Current Location',
                    unit: 'C',
                  ),
                  FutureWeatherWidget(
                    futureWeather: futureWeather,
                  ),
                  Details(
                    weather_info: currentWeather,
                    pollution_info: airPollution,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refresh() {
    return Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
  }
}
