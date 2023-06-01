import 'package:get/get_utils/get_utils.dart';
import 'package:weather_v2_pepe/app/const/weather_icon.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

class FutureWeather {
  String? cod;
  int? message;
  int? cnt;
  List<Weather>? list;
  City? city;

  FutureWeather({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  FutureWeather.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <Weather>[];
      json['list'].forEach((v) {
        list?.add(Weather.fromJson(v));
      });
    }
    city = json['city'] != null ? City?.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    return data;
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord?.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['coord'] = coord;
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    data['id'] = id;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class Coord {
  double? lat;
  double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  Coord.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num).toDouble();
    lon = (json['lon'] as num).toDouble();
  }
}

extension WeatherIconExtension on WeatherDetail {
  WeatherIcon? get weatherIcon {
    return WeatherIcon.values.firstWhereOrNull((e) => e.keyValue == icon);
  }
}
