import 'package:get/get_utils/get_utils.dart';
import 'package:weather_v2_pepe/app/const/weather_icon_extension.dart';
import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

class FutureWeather {
  String? cod;
  int? message;
  int? cnt;
  List<FutureWeatherData>? list;

  FutureWeather({this.cod, this.message, this.cnt, this.list});

  FutureWeather.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <FutureWeatherData>[];
      json['list'].forEach((v) {
        list?.add(FutureWeatherData.fromJson(v));
      });
    }
  }
}

class FutureWeatherData {
  int? dt;
  Main? main;
  List<FutureWeatherDetail>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Rain? rain;
  Sys? sys;
  String? dtTxt;

  FutureWeatherData({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  FutureWeatherData.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main?.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <FutureWeatherDetail>[];
      json['weather'].forEach((v) {
        weather?.add(FutureWeatherDetail.fromJson(v));
      });
    }
    clouds = json['clouds'] != null ? Clouds?.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? Wind?.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = (json['pop'] as num).toDouble();
    rain = json['rain'] != null ? Rain?.fromJson(json['rain']) : null;
    sys = json['sys'] != null ? Sys?.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = (json['temp'] as num).toDouble();
    feelsLike = (json['feels_like'] as num).toDouble();
    tempMin = (json['temp_min'] as num).toDouble();
    tempMax = (json['temp_max'] as num).toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = (json['temp_kf'] as num).toDouble();
  }
}

class FutureWeatherDetail {
  int? id;
  String? main;
  String? description;
  String? icon;

  FutureWeatherDetail({this.id, this.main, this.description, this.icon});

  FutureWeatherDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = (json['speed'] as num).toDouble();
    deg = json['deg'];
    gust = (json['gust'] as num).toDouble();
  }
}

class Rain {
  double? d3h;

  Rain({this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = (json['3h'] as num).toDouble();
  }
}

class Sys {
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}

extension WeatherIconExtension on FutureWeatherDetail {
  WeatherIcon? get weatherIcon {
    return WeatherIcon.values.firstWhereOrNull((e) => e.keyValue == icon);
  }
}
