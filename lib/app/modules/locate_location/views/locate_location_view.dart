import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/utils/loading_indicator.dart';
import 'package:weather_v2_pepe/app/widgets/show_list.dart';
import 'package:weather_v2_pepe/app/widgets/weather_card.dart';

import '../controllers/locate_location_controller.dart';

class LocateLocationView extends GetView<LocateLocationController> {
  const LocateLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: _appbar(),
            body: _body(),
          ),
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
      title: const Text('Weather'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: controller.goSetting,
          icon: const Icon(
            Icons.settings,
          ),
        ),
      ],
    );
  }

  _body() {
    return Obx(
      () {
        return Container(
          color: AppColors.backgroundColor,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.map,
                          size: 24,
                        ),
                        onPressed: () {
                          controller
                              .goOpenMap(controller.yourLocationNow.value);
                        },
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          cursorColor: AppColors.primaryNight,
                          controller: controller.searchTextCityController,
                          style: const TextStyle(
                            color: AppColors.primaryNight,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryBox,
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.primaryNight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: controller.searchCityText != ''
                      ? SizedBox(
                          width: double.infinity,
                          height: 600,
                          child: ListView.builder(
                            itemCount: controller.geocoding.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () =>
                                    controller.changeDataAndGoShowDetail(
                                        controller.geocoding[index]),
                                child: Container(
                                  color: AppColors.backgroundColor,
                                  child: ShowList(
                                    item: controller.geocoding[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 600,
                          child: controller.weather.isNotEmpty
                              ? ListView.builder(
                                  itemCount: controller.weather.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 4,
                                      ),
                                      child: WeatherCard(
                                        weather_info: controller.weather[index],
                                        unit: controller.temperatureUnit.value,
                                        onTap: () => controller.goShowDetail(
                                            controller
                                                .dataFavoriteLocations[index]),
                                        onTapDel: () => controller
                                            .deleteFavoriteIndex(index),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
