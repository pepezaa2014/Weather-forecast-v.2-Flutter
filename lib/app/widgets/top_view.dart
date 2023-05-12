import 'package:flutter/material.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/weather_icon_extension.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';
import 'package:collection/collection.dart';

class TopView extends StatelessWidget {
  TopView({
    super.key,
    required this.weather_info,
    required this.location_now,
    required this.unit,
  });

  final Weather? weather_info;
  final String? location_now;
  final Temperature? unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  weather_info?.name?.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNight,
                  ),
                ),
                Text(
                  weather_info?.sys?.country.toString() ?? 'No Info',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryNight,
                  ),
                ),
                Text(
                  location_now ?? '',
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
                      weather_info?.weather
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
                            weather_info?.weather
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
                            weather_info?.weather
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
                  '${unit?.convertTemp(weather_info?.main?.temp ?? 0.0).toStringAsFixed(0) ?? ''} ${unit?.tempName ?? ''}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: AppColors.primaryNight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'H:${unit?.convertTemp(weather_info?.main?.tempMax ?? 0.0).toStringAsFixed(0) ?? ''} ${unit?.tempName ?? ''} L:${unit?.convertTemp(weather_info?.main?.tempMin ?? 0.0).toStringAsFixed(0) ?? ''} ${unit?.tempName ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryNight,
                  ),
                ),
                Text(
                  'Feels like ${unit?.convertTemp(weather_info?.main?.feelsLike ?? 0.0).toStringAsFixed(0) ?? ''} ${unit?.tempName ?? ''}',
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
