import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance.dart';
import 'package:weather_v2_pepe/app/const/precipitation.dart';
import 'package:weather_v2_pepe/app/const/pressure.dart';
import 'package:weather_v2_pepe/app/const/temperature.dart';
import 'package:weather_v2_pepe/app/const/time.dart';
import 'package:weather_v2_pepe/app/const/wind_speed.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appbar(),
      body: _body(),
    );
  }

  _appbar() {
    return AppBar(
      title: Text(
        LocaleKeys.setting_title.tr,
      ),
      centerTitle: true,
    );
  }

  _body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBox,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          LocaleKeys.setting_temperature.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryNight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(
                          () {
                            return CupertinoSlidingSegmentedControl(
                              children: const {
                                Temperature.celcius: Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                Temperature.fahrenheit: Text(
                                  '°F',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                Temperature.kelvin: Text(
                                  'K',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                              },
                              groupValue: controller.temperatureUnit.value,
                              onValueChanged: (value) {
                                controller.changeSettingTemp(
                                    value ?? Temperature.celcius);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.primaryDivider,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          LocaleKeys.setting_windSpeed.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryNight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(
                          () {
                            return CupertinoSlidingSegmentedControl(
                              children: const {
                                WindSpeed.ms: Text(
                                  'm/s',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                WindSpeed.kmh: Text(
                                  'km/h',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                WindSpeed.mph: Text(
                                  'mph',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                              },
                              groupValue: controller.windUnit.value,
                              onValueChanged: (value) {
                                controller
                                    .changeSettingWind(value ?? WindSpeed.ms);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.primaryDivider,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          LocaleKeys.setting_pressure.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryNight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(
                          () {
                            return CupertinoSlidingSegmentedControl(
                              children: const {
                                Pressure.hpa: Text(
                                  'hPa',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                Pressure.inhg: Text(
                                  'InHg',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                              },
                              groupValue: controller.pressureUnit.value,
                              onValueChanged: (value) {
                                controller.changeSettingPressure(
                                    value ?? Pressure.hpa);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.primaryDivider,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          LocaleKeys.setting_precipitation.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryNight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(
                          () {
                            return CupertinoSlidingSegmentedControl(
                              children: const {
                                Precipitation.mm: Text(
                                  'mm',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                Precipitation.inn: Text(
                                  'in',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                              },
                              groupValue: controller.precipitationUnit.value,
                              onValueChanged: (value) {
                                controller.changeSettingPrecipitataion(
                                    value ?? Precipitation.mm);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.primaryDivider,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          LocaleKeys.setting_distance.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryNight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(
                          () {
                            return CupertinoSlidingSegmentedControl(
                              children: const {
                                Distance.km: Text(
                                  'km',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                                Distance.mi: Text(
                                  'mi',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.fourthNight,
                                  ),
                                ),
                              },
                              groupValue: controller.distanceUnit.value,
                              onValueChanged: (value) {
                                controller.changeSettingDistance(
                                    value ?? Distance.km);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBox,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      LocaleKeys.setting_timeFormat.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryNight,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Obx(
                      () {
                        return CupertinoSlidingSegmentedControl(
                          children: {
                            Time.h24: Text(
                              LocaleKeys.setting_h24.tr,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.fourthNight,
                              ),
                            ),
                            Time.h12: Text(
                              LocaleKeys.setting_h12.tr,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.fourthNight,
                              ),
                            ),
                          },
                          groupValue: controller.timeUnit.value,
                          onValueChanged: (value) {
                            controller.changeSettingTime(value ?? Time.h24);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
