class Setting {
  int? temperature;
  int? windSpeed;
  int? pressure;
  int? precipitatation;
  int? distance;
  int? timeFormat;

  Setting.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    windSpeed = json['windSpeed'];
    pressure = json['pressure'];
    precipitatation = json['precipitatation'];
    distance = json['distance'];
    timeFormat = json['timeFormat'];
  }
}
