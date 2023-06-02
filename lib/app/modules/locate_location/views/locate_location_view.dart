import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
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
            backgroundColor: AppColors.backgroundColor,
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

        final searchText = controller.searchTextCityController;

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _textField(
                context: context,
                searchText: searchText,
              ),
              controller.searchCityText.value != ''
                  ? _geocoding(
                      geocoding: geocoding,
                      searchText: searchText,
                    )
                  : _weatherCard(
                      currentLocation: currentLocation,
                      dataFavorite: dataFavorite,
                      setting: setting,
                    )
            ],
          ),
        );
      },
    );
  }

  _textField({
    required TextEditingController searchText,
    required BuildContext context,
  }) {
    return Padding(
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
          Expanded(
            child: SizedBox(
              child: TextField(
                cursorColor: AppColors.primaryNight,
                controller: searchText,
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
                      searchText.clear();
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
          ),
        ],
      ),
    );
  }

  _geocoding({
    required RxList geocoding,
    required TextEditingController searchText,
  }) {
    return RefreshIndicator(
      onRefresh: () => controller.updateWeather(),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: ListView.builder(
          itemCount: geocoding.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                searchText.clear();
                controller.changeDataAndGoShowDetail(geocoding[index]);
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
      ),
    );
  }

  _weatherCard({
    required Weather? currentLocation,
    required List<Weather> dataFavorite,
    required Setting setting,
  }) {
    return RefreshIndicator(
      onRefresh: () => controller.updateWeather(),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: dataFavorite.isNotEmpty || currentLocation != null
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
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
                        onTapDel: () => controller.deleteFavoriteIndex(index),
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
      ),
    );
  }
}
