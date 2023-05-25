import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';

class Setting {
  Temperature temperature = Temperature.celcius;
  WindSpeed windSpeed = WindSpeed.ms;
  Pressure pressure = Pressure.hpa;
  Precipitation precipitation = Precipitation.mm;
  Distance distance = Distance.km;
  Time timeFormat = Time.h24;

  Setting();

  Setting.fromJson(Map<String, dynamic> json) {
    temperature = Temperature.values
            .firstWhereOrNull((e) => e == (json['temperature'])) ??
        Temperature.celcius;
    windSpeed =
        WindSpeed.values.firstWhereOrNull((e) => e == (json['windSpeed'])) ??
            WindSpeed.ms;
    pressure =
        Pressure.values.firstWhereOrNull((e) => e == (json['pressure'])) ??
            Pressure.hpa;
    precipitation = Precipitation.values
            .firstWhereOrNull((e) => e == (json['precipitation'])) ??
        Precipitation.mm;
    distance =
        Distance.values.firstWhereOrNull((e) => e == (json['distance'])) ??
            Distance.km;
    timeFormat =
        Time.values.firstWhereOrNull((e) => e == (json['timeFormat'])) ??
            Time.h24;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temperature'] = temperature.name;
    data['windSpeed'] = windSpeed.name;
    data['pressure'] = pressure.name;
    data['precipitation'] = precipitation.name;
    data['distance'] = distance.name;
    data['timeFormat'] = timeFormat.name;
    return data;
  }
}
