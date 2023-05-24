import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  _appbar() {
    return AppBar(
      title: const Text('Settings'),
      centerTitle: true,
    );
  }

  _body() {
    return Container(
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryBox,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Temperature',
                        style: TextStyle(
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
                            groupValue:
                                controller.dataSetting.value?.temperature,
                            onValueChanged: (value) {
                              controller.changeSettingTemp(value);
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
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Wind Speed',
                        style: TextStyle(
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
                            groupValue: controller.dataSetting.value?.windSpeed,
                            onValueChanged: (value) {
                              controller.changeSettingWind(value);
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
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Pressure',
                        style: TextStyle(
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
                            groupValue: controller.dataSetting.value?.pressure,
                            onValueChanged: (value) {
                              controller.changeSettingPressure(value);
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
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Precipitation',
                        style: TextStyle(
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
                            groupValue:
                                controller.dataSetting.value?.precipitation,
                            onValueChanged: (value) {
                              controller.changeSettingPrecipitataion(value);
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
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Distance',
                        style: TextStyle(
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
                            groupValue: controller.dataSetting.value?.distance,
                            onValueChanged: (value) {
                              controller.changeSettingDistance(value);
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
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Time Format',
                        style: TextStyle(
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
                              Time.h24: Text(
                                '24-hour',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              Time.h12: Text(
                                '12-hour',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue:
                                controller.dataSetting.value?.timeFormat,
                            onValueChanged: (value) {
                              controller.changeSettingTime(value);
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
    );
  }
}
