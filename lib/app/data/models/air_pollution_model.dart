class AirPollution {
  List<double>? coord;
  List<AirPollutionData>? list;

  AirPollution({this.coord, this.list});

  AirPollution.fromJson(Map<String, dynamic> json) {
    coord = json['coord'].cast<double>();
    if (json['list'] != null) {
      list = <AirPollutionData>[];
      json['list'].forEach((v) {
        list?.add(AirPollutionData.fromJson(v));
      });
    }
  }
}

class AirPollutionData {
  late int dt;
  late MainData main;
  late ComponentsData components;

  AirPollutionData(
      {required this.dt, required this.main, required this.components});

  AirPollutionData.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = MainData.fromJson(json['main']);
    components = ComponentsData.fromJson(json['components']);
  }
}

class MainData {
  late double aqi;

  MainData({required this.aqi});

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

  ComponentsData({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  ComponentsData.fromJson(Map<String, dynamic> json) {
    co = json['co'];
    no = json['no'];
    no2 = json['no2'];
    o3 = json['o3'];
    so2 = json['so2'];
    pm2_5 = json['pm2_5'];
    pm10 = json['pm10'];
    nh3 = json['nh3'];
  }
}
