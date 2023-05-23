import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';

class Setting {
  Temperature? temperature;
  WindSpeed? windSpeed;
  Pressure? pressure;
  Precipitation? precipitation;
  Distance? distance;
  Time? timeFormat;

  Setting({
    this.temperature,
    this.windSpeed,
    this.pressure,
    this.precipitation,
    this.distance,
    this.timeFormat,
  });

  Setting.fromJson(Map<String, dynamic> json) {
    temperature = Temperature.values
        .firstWhereOrNull((e) => e.keyValue == (json['temperature'] as int?));
    windSpeed = WindSpeed.values
        .firstWhereOrNull((e) => e.keyValue == (json['windSpeed']) as int?);
    pressure = Pressure.values
        .firstWhereOrNull((e) => e.keyValue == (json['pressure']) as int?);
    precipitation = Precipitation.values
        .firstWhereOrNull((e) => e.keyValue == (json['precipitation']) as int?);
    distance = Distance.values
        .firstWhereOrNull((e) => e.keyValue == (json['distance']) as int?);
    timeFormat = Time.values
        .firstWhereOrNull((e) => e.keyValue == (json['timeFormat']) as int?);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temperature'] = temperature?.keyValue;
    data['windSpeed'] = windSpeed?.keyValue;
    data['pressure'] = pressure?.keyValue;
    data['precipitation'] = precipitation?.keyValue;
    data['distance'] = distance?.keyValue;
    data['timeFormat'] = timeFormat?.keyValue;
    return data;
  }
}

extension TemperatureExtension on Setting {
  Temperature? get temperatureData {
    return Temperature.values.firstWhereOrNull((e) => e == temperature);
  }
}

extension WindSpeedExtension on Setting {
  WindSpeed? get windSpeedData {
    return WindSpeed.values.firstWhereOrNull((e) => e == windSpeed);
  }
}

extension PressureExtension on Setting {
  Pressure? get pressureData {
    return Pressure.values.firstWhereOrNull((e) => e == pressure);
  }
}

extension PrecipitationExtension on Setting {
  Precipitation? get precipitationData {
    return Precipitation.values.firstWhereOrNull((e) => e == precipitation);
  }
}

extension DistanceExtension on Setting {
  Distance? get distanceData {
    return Distance.values.firstWhereOrNull((e) => e == distance);
  }
}

extension TimeExtension on Setting {
  Time? get timeData {
    return Time.values.firstWhereOrNull((e) => e == timeFormat);
  }
}
