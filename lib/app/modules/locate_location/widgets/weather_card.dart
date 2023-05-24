import 'package:flutter/material.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:weather_v2_pepe/app/const/weather_icon_extension.dart';
import 'package:collection/collection.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.boolFirst,
    required this.weatherInfo,
    required this.tempUnit,
    required this.timeUnit,
    required this.onTap,
    required this.onTapDel,
  });

  final bool boolFirst;
  final Weather? weatherInfo;
  final Temperature? tempUnit;
  final Time? timeUnit;
  final Function() onTap;
  final Function() onTapDel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryBox,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            weatherInfo?.name ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryNight,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            boolFirst
                                ? 'Current Location'
                                : timeUnit?.convertTimeWithTimeZone(
                                        (weatherInfo?.dt ?? 0),
                                        (weatherInfo?.timezone ?? 0)) ??
                                    '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.secondaryNight,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              weatherInfo?.weather
                                      ?.firstWhereOrNull((e) => true)
                                      ?.weatherIcon
                                      ?.imageName
                                      .toString() ??
                                  '',
                              width: 60,
                              height: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  weatherInfo?.weather
                                          ?.firstWhereOrNull((element) => true)
                                          ?.main
                                          .toString() ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryNight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '${tempUnit?.convertTemperature(weatherInfo?.main?.temp ?? 0.0).toStringAsFixed(0) ?? ''} ${tempUnit?.tempName ?? ''}',
                            style: const TextStyle(
                              fontSize: 40,
                              color: AppColors.primaryNight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'H:${tempUnit?.convertTemperature(weatherInfo?.main?.tempMax ?? 0.0).toStringAsFixed(0) ?? ''} ${tempUnit?.tempName ?? ''} L:${tempUnit?.convertTemperature(weatherInfo?.main?.tempMin ?? 0.0).toStringAsFixed(0) ?? ''} ${tempUnit?.tempName ?? ''}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryNight,
                            ),
                          ),
                          Text(
                            'Feels like ${tempUnit?.convertTemperature(weatherInfo?.main?.feelsLike ?? 0.0).toStringAsFixed(0) ?? ''} ${tempUnit?.tempName ?? ''}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.thirdaryNight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: boolFirst
              ? const SizedBox()
              : IconButton(
                  onPressed: onTapDel,
                  icon: const Icon(
                    Icons.restore_from_trash,
                    size: 24,
                    color: AppColors.primaryNight,
                  ),
                ),
        ),
      ],
    );
  }
}