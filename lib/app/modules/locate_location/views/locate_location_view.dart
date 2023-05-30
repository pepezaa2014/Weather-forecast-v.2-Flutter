import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/utils/loading_indicator.dart';
import 'package:weather_v2_pepe/app/modules/locate_location/widgets/show_list.dart';
import 'package:weather_v2_pepe/app/modules/locate_location/widgets/weather_card.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';

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
            appBar: _appbar(context),
            body: _body(context),
          ),
        ),
        Obx(
          () =>
              LoadingIndicator(isLoading: controller.isLoadingGetWeather.value),
        ),
      ],
    );
  }

  _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.home_title.tr,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.goSetting();
          },
          icon: const Icon(
            Icons.settings,
          ),
        ),
      ],
    );
  }

  _body(BuildContext context) {
    return Obx(
      () {
        final allWeatherData = controller.allWeatherData.value;
        final geocoding = controller.geocoding;
        final currentLocation = controller.currentLocation.value;
        final dataFavorite = controller.dataFavoriteLocations.value;

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
                          FocusScope.of(context).unfocus();
                          controller
                              .goOpenMap(controller.currentLocation.value);
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
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                controller.searchTextCityController.clear();
                              },
                            ),
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
                  child: controller.searchCityText.value != ''
                      ? SizedBox(
                          width: double.infinity,
                          height: 600,
                          child: ListView.builder(
                            itemCount: geocoding.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () =>
                                    controller.changeDataAndGoShowDetail(
                                        geocoding[index]),
                                child: Container(
                                  color: AppColors.backgroundColor,
                                  child: ShowList(
                                    item: geocoding[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 600,
                          child: allWeatherData.isNotEmpty
                              ? ListView.builder(
                                  itemCount: allWeatherData.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 4,
                                      ),
                                      child: WeatherCard(
                                        currentLocation: currentLocation,
                                        weatherInfo: index == 0 ||
                                                currentLocation != null
                                            ? allWeatherData.firstWhereOrNull(
                                                (element) =>
                                                    element.id ==
                                                    currentLocation.id)
                                            : allWeatherData.firstWhereOrNull(
                                                (element) =>
                                                    element.id ==
                                                    dataFavorite[index].id),
                                        setting: controller.dataSetting.value,
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          controller.goShowDetail(
                                              allWeatherData[index]);
                                        },
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
