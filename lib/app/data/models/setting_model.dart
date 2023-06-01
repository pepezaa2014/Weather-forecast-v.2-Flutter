import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/distance.dart';
import 'package:weather_v2_pepe/app/const/precipitation.dart';
import 'package:weather_v2_pepe/app/const/pressure.dart';
import 'package:weather_v2_pepe/app/const/temperature.dart';
import 'package:weather_v2_pepe/app/const/time.dart';
import 'package:weather_v2_pepe/app/const/wind_speed.dart';

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
            .firstWhereOrNull((e) => e.name == (json['temperature'])) ??
        Temperature.celcius;
    windSpeed = WindSpeed.values
            .firstWhereOrNull((e) => e.name == (json['windSpeed'])) ??
        WindSpeed.ms;
    pressure =
        Pressure.values.firstWhereOrNull((e) => e.name == (json['pressure'])) ??
            Pressure.hpa;
    precipitation = Precipitation.values
            .firstWhereOrNull((e) => e.name == (json['precipitation'])) ??
        Precipitation.mm;
    distance =
        Distance.values.firstWhereOrNull((e) => e.name == (json['distance'])) ??
            Distance.km;
    timeFormat =
        Time.values.firstWhereOrNull((e) => e.name == (json['timeFormat'])) ??
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
