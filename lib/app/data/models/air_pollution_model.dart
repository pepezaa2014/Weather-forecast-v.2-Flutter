import 'package:get/get_utils/get_utils.dart';
import 'package:weather_v2_pepe/app/const/aqi_extension.dart';

class AirPollution {
  Coord? coord;
  List<AirPollutionData>? list;

  AirPollution({
    this.coord,
    this.list,
  });

  AirPollution.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord?.fromJson(json['coord']) : null;

    if (json['list'] != null) {
      list = <AirPollutionData>[];
      json['list'].forEach((v) {
        list?.add(AirPollutionData.fromJson(v));
      });
    }
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

class AirPollutionData {
  late double dt;
  late MainData main;
  late ComponentsData components;

  AirPollutionData.fromJson(Map<String, dynamic> json) {
    dt = (json['dt'] as num).toDouble();
    main = MainData.fromJson(json['main']);
    components = ComponentsData.fromJson(json['components']);
  }
}

class MainData {
  late int aqi;

  MainData.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'];
  }
}

class ComponentsData {
  late double co;
  late double no;
  late double no2;
  late double o3;
  late double so2;
  late double pm2_5;
  late double pm10;
  late double nh3;

  ComponentsData.fromJson(Map<String, dynamic> json) {
    co = (json['co'] as num).toDouble();
    no = (json['no'] as num).toDouble();
    no2 = (json['no2'] as num).toDouble();
    o3 = (json['o3'] as num).toDouble();
    so2 = (json['so2'] as num).toDouble();
    pm2_5 = (json['pm2_5'] as num).toDouble();
    pm10 = (json['pm10'] as num).toDouble();
    nh3 = (json['nh3'] as num).toDouble();
  }
}

extension AQIExtension on MainData {
  AQI? get airQuality {
    return AQI.values.firstWhereOrNull((e) => e.keyValue == aqi);
  }
}
