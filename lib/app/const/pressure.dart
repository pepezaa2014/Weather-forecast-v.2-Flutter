enum Pressure {
  hpa,
  inhg,
}

extension PressureExtension on Pressure {
  String get pressureName {
    switch (this) {
      case Pressure.hpa:
        return 'hPa';
      case Pressure.inhg:
        return 'InHg';
    }
  }

  double convertPressure(int pressure) {
    switch (this) {
      case Pressure.hpa:
        return (pressure).toDouble();
      case Pressure.inhg:
        return (pressure.toDouble()) / 33.86388667;
    }
  }
}
