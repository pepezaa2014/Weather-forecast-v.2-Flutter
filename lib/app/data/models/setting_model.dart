import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/distance_extension.dart';
import 'package:weather_v2_pepe/app/const/precipitation_extension.dart';
import 'package:weather_v2_pepe/app/const/pressure_extension.dart';
import 'package:weather_v2_pepe/app/const/temperature_extension.dart';
import 'package:weather_v2_pepe/app/const/time_extension.dart';
import 'package:weather_v2_pepe/app/const/wind_speed_extension.dart';

class Setting {
  int? temperature;
  int? windSpeed;
  int? pressure;
  int? precipitation;
  int? distance;
  int? timeFormat;

  Setting({
    this.temperature,
    this.windSpeed,
    this.pressure,
    this.precipitation,
    this.distance,
    this.timeFormat,
  });

  Setting.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    windSpeed = json['windSpeed'];
    pressure = json['pressure'];
    precipitation = json['precipitation'];
    distance = json['distance'];
    timeFormat = json['timeFormat'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temperature'] = temperature;
    data['windSpeed'] = windSpeed;
    data['pressure'] = pressure;
    data['precipitatation'] = precipitation;
    data['distance'] = distance;
    data['timeFormat'] = timeFormat;
    return data;
  }
}

extension TemperatureExtension on Setting {
  Temperature? get temperatureName {
    return Temperature.values
        .firstWhereOrNull((e) => e.keyValue == temperature);
  }
}

extension WindSpeedExtension on Setting {
  WindSpeed? get temperatureName {
    return WindSpeed.values.firstWhereOrNull((e) => e.keyValue == windSpeed);
  }
}

extension PressureExtension on Setting {
  Pressure? get temperatureName {
    return Pressure.values.firstWhereOrNull((e) => e.keyValue == pressure);
  }
}

extension PrecipitationExtension on Setting {
  Precipitation? get temperatureName {
    return Precipitation.values
        .firstWhereOrNull((e) => e.keyValue == precipitation);
  }
}

extension DistanceExtension on Setting {
  Distance? get temperatureName {
    return Distance.values.firstWhereOrNull((e) => e.keyValue == distance);
  }
}

extension TimeExtension on Setting {
  Time? get temperatureName {
    return Time.values.firstWhereOrNull((e) => e.keyValue == timeFormat);
  }
}
