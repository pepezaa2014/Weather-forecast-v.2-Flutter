import 'package:flutter/material.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';

class ShowList extends StatelessWidget {
  const ShowList({
    super.key,
    required this.item,
    required this.onTap,
  });

  final Geocoding? item;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    String state = '${item?.state.toString() ?? ''}, ';
    String country = item?.country.toString() ?? '';

    if (state == 'null, ') {
      state = '';
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            item?.name.toString() ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNight,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '$state$country',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNight,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Divider(
            height: 4,
            color: AppColors.primaryNight,
          ),
        ),
      ],
    );
  }
}