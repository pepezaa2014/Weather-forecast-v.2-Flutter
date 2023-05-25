enum WindSpeed {
  ms,
  kmh,
  mph,
}

extension WindSpeedExtension on WindSpeed {
  String get windName {
    switch (this) {
      case WindSpeed.ms:
        return 'm/s';
      case WindSpeed.kmh:
        return 'km/h';
      case WindSpeed.mph:
        return 'mph';
    }
  }

  double convertWind(double windSpeed) {
    switch (this) {
      case WindSpeed.mph:
        return windSpeed * 2.23694;
      case WindSpeed.kmh:
        return windSpeed * 3.6;
      case WindSpeed.ms:
        return windSpeed;
    }
  }
}
