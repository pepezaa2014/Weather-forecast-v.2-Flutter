import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:intl/intl.dart';
import 'package:weather_v2_pepe/app/const/aqi_extension.dart';
import 'package:weather_v2_pepe/resources/resources.dart';

class Details extends StatelessWidget {
  Details({
    super.key,
    required this.weather_info,
    required this.pollution_info,
  });

  final Weather? weather_info;
  final AirPollution? pollution_info;

  @override
  Widget build(BuildContext context) {
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(
        ((weather_info?.sys?.sunrise)?.toInt() ?? 0) * 1000);
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(
        ((weather_info?.sys?.sunset)?.toInt() ?? 0) * 1000);

    final timeFormat = DateFormat('h:mm a');
    final sunriseTimeString = timeFormat.format(sunriseTime);
    final sunsetTimeString = timeFormat.format(sunsetTime);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _item(
                  head: 'AQI',
                  description: pollution_info?.list
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
                  description: pollution_info?.list
                          ?.firstWhereOrNull((element) => true)
                          ?.components
                          .pm2_5
                          .toStringAsFixed(2) ??
                      '-',
                  unit: ' μg/m3',
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
                  head: 'Sunrise',
                  description: sunriseTimeString,
                ),
              ),
              Expanded(
                child: _itemTime(
                  head: 'Sunset',
                  description: sunsetTimeString,
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
                  head: 'Wind',
                  description: weather_info?.wind?.speed.toString() ?? '',
                  degree: (weather_info?.wind?.deg as num).toDouble(),
                ),
              ),
              Expanded(
                child: _itemPressure(
                  head: 'Pressure',
                  description: weather_info?.main?.pressure.toString() ?? '',
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
                  head: 'Visibility',
                  description: weather_info?.visibility?.toString() ?? '-',
                ),
              ),
              Expanded(
                child: _item(
                  head: 'Humidity',
                  description: weather_info?.main?.humidity?.toString() ?? '',
                  unit: '%',
                ),
              ),
            ],
          ),
        ),
      ],
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

  _itemPrecipitation({
    required String head,
    required String description,
    String? unitPrecipitation,
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
          description + (unitPrecipitation ?? ''),
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
    String? unitVisibility,
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
          description + (unitVisibility ?? ''),
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
    String? unitPressure,
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
          description + (unitPressure ?? ''),
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
    String? unitWind,
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
              description + (unitWind ?? ''),
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryNight,
              ),
            ),
            Transform.rotate(
              angle: degree * 3.14 / 180,
              child: Image.asset(
                ImageName.navigationBar,
                width: 20,
                height: 20,
                color: AppColors.primaryNight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
