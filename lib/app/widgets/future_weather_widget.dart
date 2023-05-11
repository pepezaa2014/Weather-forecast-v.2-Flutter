import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';
import 'package:weather_v2_pepe/app/const/weather_icon_extension.dart';

class FutureWeatherWidget extends StatelessWidget {
  const FutureWeatherWidget({
    super.key,
    required this.futureWeather,
  });

  final FutureWeather? futureWeather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryBox,
        ),
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: futureWeather?.list?.length,
            itemBuilder: (BuildContext context, int index) {
              return _oneForm(
                date: futureWeather?.list?[index].dtTxt ?? '',
                description: futureWeather?.list?[index].weather
                        ?.firstWhereOrNull((element) => true)
                        ?.main ??
                    '',
                iconName: futureWeather?.list?[index].weather
                        ?.firstWhereOrNull((element) => true)
                        ?.weatherIcon
                        ?.imageName
                        .toString() ??
                    '',
              );
            },
          ),
        ),
      ),
    );
  }

  _oneForm({
    required String? date,
    required String? description,
    required String? iconName,
  }) {
    DateTime dateTime = DateTime.parse(date ?? '');
    String formattedMonthDate = DateFormat('MMMM dd').format(dateTime);
    String formattedTime = DateFormat('hh:mm').format(dateTime);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              formattedMonthDate,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondaryNight,
              ),
            ),
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondaryNight,
              ),
            ),
            Image.asset(
              iconName ?? '',
              width: 32,
              height: 32,
            ),
            Text(
              description ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondaryNight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
