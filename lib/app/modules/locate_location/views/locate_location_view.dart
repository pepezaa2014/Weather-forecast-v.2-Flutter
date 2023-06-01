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
          () => LoadingIndicator(
            isLoading: controller.isLoading.value,
          ),
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
        final geocoding = controller.geocoding;

        final currentLocation = controller.currentLocation.value;
        final dataFavorite = controller.dataFavoriteLocations.value;
        final setting = controller.dataSetting.value;

        final serchText = controller.searchTextCityController;

        return Container(
          color: AppColors.backgroundColor,
          height: double.infinity,
          child: RefreshIndicator(
            onRefresh: () => controller.updateWeather(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
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
                            controller.goOpenMap();
                          },
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            cursorColor: AppColors.primaryNight,
                            controller: serchText,
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
                                  serchText.clear();
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
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    serchText.clear();
                                    controller.changeDataAndGoShowDetail(
                                        geocoding[index]);
                                  },
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
                            child: dataFavorite.isNotEmpty ||
                                    currentLocation != null
                                ? ListView.builder(
                                    itemCount: currentLocation != null
                                        ? dataFavorite.length + 1
                                        : dataFavorite.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        child: WeatherCard(
                                          currentLocation: currentLocation,
                                          weatherInfo: currentLocation != null
                                              ? index == 0
                                                  ? currentLocation
                                                  : dataFavorite[index - 1]
                                              : dataFavorite[index],
                                          setting: setting,
                                          onTap: () {
                                            FocusScope.of(context).unfocus();

                                            controller.goShowDetail(
                                              currentLocation != null
                                                  ? index == 0
                                                      ? currentLocation
                                                      : dataFavorite[index - 1]
                                                  : dataFavorite[index],
                                            );
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
          ),
        );
      },
    );
  }
}
