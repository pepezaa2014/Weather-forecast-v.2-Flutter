import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/distance.dart';
import 'package:weather_v2_pepe/app/const/pressure.dart';
import 'package:weather_v2_pepe/app/const/time.dart';
import 'package:weather_v2_pepe/app/const/wind_speed.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/const/aqi.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';
import 'package:weather_v2_pepe/resources/resources.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.weatherInfo,
    required this.pollutionInfo,
    required this.setting,
  });

  final Setting? setting;
  final Weather? weatherInfo;
  final AirPollution? pollutionInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _item(
                    head: 'AQI',
                    description: pollutionInfo?.list
                            ?.firstWhereOrNull((element) => true)
                            ?.main
                            .airQuality
                            ?.detail
                            .toString() ??
                        '-',
                  ),
                ),
                Expanded(
                  child: _item(
                    head: 'PM2.5',
                    description: pollutionInfo?.list
                            ?.firstWhereOrNull((element) => true)
                            ?.components
                            .pm2_5
                            .toStringAsFixed(2) ??
                        '-',
                    unit: ' μg/\u{33A5}',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _itemTime(
                    head: LocaleKeys.home_sunrise.tr,
                    description: setting?.timeFormat.convertTimeWithTimeZoneSun(
                            (weatherInfo?.sys?.sunrise ?? 0),
                            (weatherInfo?.timezone ?? 0)) ??
                        '',
                  ),
                ),
                Expanded(
                  child: _itemTime(
                    head: LocaleKeys.home_sunset.tr,
                    description: setting?.timeFormat.convertTimeWithTimeZoneSun(
                            (weatherInfo?.sys?.sunset ?? 0),
                            (weatherInfo?.timezone ?? 0)) ??
                        '',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _itemWind(
                    head: LocaleKeys.home_wind.tr,
                    description: setting?.windSpeed
                            .convertWind(weatherInfo?.wind?.speed ?? 0)
                            .toStringAsFixed(2) ??
                        '',
                    unitWind: setting?.windSpeed.windName ?? '',
                    degree: ((weatherInfo?.wind?.deg) ?? 0).toDouble(),
                  ),
                ),
                Expanded(
                  child: _itemPressure(
                    head: LocaleKeys.home_pressure.tr,
                    description: setting?.pressure
                            .convertPressure(weatherInfo?.main?.pressure ?? 0)
                            .toStringAsFixed(0) ??
                        '',
                    unitPressure: setting?.pressure.pressureName ?? '',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _itemVisible(
                    head: LocaleKeys.home_visibility.tr,
                    description: setting?.distance
                            .convertDistance(weatherInfo?.visibility ?? 0)
                            .toStringAsFixed(2) ??
                        '',
                    unitVisibility: setting?.distance.distanceName ?? '',
                  ),
                ),
                Expanded(
                  child: _item(
                    head: LocaleKeys.home_humidity.tr,
                    description: weatherInfo?.main?.humidity?.toString() ?? '',
                    unit: '%',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _item({
    required String head,
    required String description,
    String? unit,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.thirdaryNight,
          ),
        ),
        Text(
          description + (unit ?? ''),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryNight,
          ),
        ),
      ],
    );
  }

  _itemVisible({
    required String head,
    required String description,
    required String unitVisibility,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.thirdaryNight,
          ),
        ),
        Text(
          '$description $unitVisibility',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryNight,
          ),
        ),
      ],
    );
  }

  _itemPressure({
    required String head,
    required String description,
    required String unitPressure,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.thirdaryNight,
          ),
        ),
        Text(
          '$description $unitPressure',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryNight,
          ),
        ),
      ],
    );
  }

  _itemTime({
    required String head,
    required String description,
    String? timeFormat,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.thirdaryNight,
          ),
        ),
        Text(
          description + (timeFormat ?? ''),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryNight,
          ),
        ),
      ],
    );
  }

  _itemWind({
    required String head,
    required String description,
    required double degree,
    required String unitWind,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.thirdaryNight,
          ),
        ),
        Row(
          children: [
            Text(
              '$description $unitWind',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryNight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Transform.rotate(
                angle: degree * 3.14 / 180,
                child: Image.asset(
                  ImageName.navigationBar,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
