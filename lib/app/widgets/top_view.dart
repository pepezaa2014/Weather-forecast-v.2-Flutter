import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/weather_icon_extension.dart';
import 'package:weather_v2_pepe/app/data/models/setting_model.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:collection/collection.dart';
import 'package:weather_v2_pepe/generated/locales.g.dart';

class TopView extends StatelessWidget {
  const TopView({
    super.key,
    required this.weatherInfo,
    required this.locationNow,
    required this.setting,
  });

  final Weather? weatherInfo;
  final String? locationNow;
  final Setting? setting;

  @override
  Widget build(BuildContext context) {
    String country = weatherInfo?.sys?.country.toString() ?? '';

    if (country == 'null') {
      country = '';
    }
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  weatherInfo?.name?.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNight,
                  ),
                ),
                Text(
                  country,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryNight,
                  ),
                ),
                Text(
                  locationNow ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.thirdaryNight,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            weatherInfo?.weather
                                    ?.firstWhereOrNull((element) => true)
                                    ?.main
                                    .toString() ??
                                '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryNight,
                            ),
                          ),
                          Text(
                            weatherInfo?.weather
                                    ?.firstWhereOrNull((element) => true)
                                    ?.description
                                    .toString() ??
                                '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.secondaryNight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  '${setting?.temperature.convertTemperature(weatherInfo?.main?.temp ?? 0.0).toStringAsFixed(0) ?? ''} ${setting?.temperature.tempName ?? ''}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: AppColors.primaryNight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${LocaleKeys.home_high.tr}${setting?.temperature.convertTemperature(weatherInfo?.main?.tempMax ?? 0.0).toStringAsFixed(0) ?? ''} ${setting?.temperature.tempName ?? ''}\t\t${LocaleKeys.home_low.tr}${setting?.temperature.convertTemperature(weatherInfo?.main?.tempMin ?? 0.0).toStringAsFixed(0) ?? ''} ${setting?.temperature.tempName ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryNight,
                  ),
                ),
                Text(
                  '${LocaleKeys.home_feelLike.tr} ${setting?.temperature.convertTemperature(weatherInfo?.main?.feelsLike ?? 0.0).toStringAsFixed(0) ?? ''} ${setting?.temperature.tempName ?? ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.thirdaryNight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
