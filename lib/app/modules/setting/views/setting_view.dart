import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';

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
                              0: Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              1: Text(
                                '°F',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              2: Text(
                                'K',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue: controller.temperatureUnit.value,
                            onValueChanged: (value) {
                              controller.changeSettingTemp(value as int);
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
                              0: Text(
                                'm/s',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              1: Text(
                                'km/h',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              2: Text(
                                'mph',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue: controller.windUnit.value,
                            onValueChanged: (value) {
                              controller.changeSettingWind(value as int);
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
                              0: Text(
                                'hPa',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              1: Text(
                                'InHg',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue: controller.pressureUnit.value,
                            onValueChanged: (value) {
                              controller.changeSettingPressure(value as int);
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
                              0: Text(
                                'mm',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              1: Text(
                                'in',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue: controller.precipitationUnit.value,
                            onValueChanged: (value) {
                              controller
                                  .changeSettingPrecipitataion(value as int);
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
                              0: Text(
                                'km',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              1: Text(
                                'mi',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue: controller.distanceUnit.value,
                            onValueChanged: (value) {
                              controller.changeSettingDistance(value as int);
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
                              0: Text(
                                '24-hour',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                              1: Text(
                                '12-hour',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fourthNight,
                                ),
                              ),
                            },
                            groupValue: controller.timeUnit.value,
                            onValueChanged: (value) {
                              controller.changeSettingTime(value as int);
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
