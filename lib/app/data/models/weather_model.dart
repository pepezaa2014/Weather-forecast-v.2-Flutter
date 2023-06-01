import 'package:get/get_utils/get_utils.dart';
import 'package:weather_v2_pepe/app/const/weather_icon.dart';

class Weather {
  Coord? coord;
  List<WeatherDetail>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  Snow? snow;
  Rain? rain;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;
  String? message;
  String? dtTxt;

  Weather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.snow,
    this.rain,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
    this.message,
    this.dtTxt,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord?.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <WeatherDetail>[];
      json['weather'].forEach((v) {
        weather?.add(WeatherDetail.fromJson(v));
      });
    }

    dtTxt = json['dt_txt'];

    main = json['main'] != null ? Main?.fromJson(json['main']) : null;

    wind = json['wind'] != null ? Wind?.fromJson(json['wind']) : null;
    snow = json['snow'] != null ? Snow?.fromJson(json['snow']) : null;
    rain = json['rain'] != null ? Rain?.fromJson(json['rain']) : null;

    clouds = json['clouds'] != null ? Clouds?.fromJson(json['clouds']) : null;

    sys = json['sys'] != null ? Sys?.fromJson(json['sys']) : null;
    id = json['id'];
    name = json['name'];
    visibility = json['visibility'];
    base = json['base'];
    cod = json['cod'];
    message = json['message'];
    dt = json['dt'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (coord != null) {
      data['coord'] = coord?.toJson();
    }
    if (weather != null) {
      data['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    data['base'] = base;
    if (main != null) {
      data['main'] = main?.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind?.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds?.toJson();
    }
    if (snow != null) {
      data['snow'] = snow?.toJson();
    }
    if (rain != null) {
      data['rain'] = rain?.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys?.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    data['dtTxt'] = dtTxt;
    data['message'] = message;
    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord(
    this.lat,
    this.lon,
  );

  Coord.fromJson(Map<String, dynamic> json) {
    lon = (json['lon'] as num?)?.toDouble();
    lat = (json['lat'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;

    return data;
  }
}

class WeatherDetail {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherDetail({
    this.id,
    this.description,
    this.icon,
    this.main,
  });

  WeatherDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main({
    this.feelsLike,
    this.grndLevel,
    this.humidity,
    this.pressure,
    this.seaLevel,
    this.temp,
    this.tempMax,
    this.tempMin,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = (json['temp'] as num?)?.toDouble();
    feelsLike = (json['feels_like'] as num?)?.toDouble();
    tempMin = (json['temp_min'] as num?)?.toDouble();
    tempMax = (json['temp_max'] as num?)?.toDouble();
    pressure = (json['pressure']);
    humidity = (json['humidity']);
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({
    this.deg,
    this.gust,
    this.speed,
  });

  Wind.fromJson(Map<String, dynamic> json) {
    speed = (json['speed'] as num?)?.toDouble();
    deg = json['deg'];
    gust = (json['gust'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({
    this.country,
    this.id,
    this.sunrise,
    this.sunset,
    this.type,
  });

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class Snow {
  double? d1h;
  double? d3h;

  Snow({
    this.d1h,
    this.d3h,
  });

  Snow.fromJson(Map<String, dynamic> json) {
    d1h = (json['1h'] as num?)?.toDouble();
    d3h = (json['3h'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['d1h'] = d1h;
    data['d3h'] = d3h;
    return data;
  }
}

class Rain {
  double? d1h;
  double? d3h;

  Rain({
    this.d1h,
    this.d3h,
  });

  Rain.fromJson(Map<String, dynamic> json) {
    d1h = (json['1h'] as num?)?.toDouble();
    d3h = (json['3h'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['d1h'] = d1h;
    data['d3h'] = d3h;
    return data;
  }
}

extension WeatherIconExtension on WeatherDetail {
  WeatherIcon? get weatherIcon {
    return WeatherIcon.values.firstWhereOrNull((e) => e.keyValue == icon);
  }
}
