enum Pressure {
  hpa,
  inhg,
}

extension PressureExtension on Pressure {
  int get keyValue {
    switch (this) {
      case Pressure.hpa:
        return 0;
      case Pressure.inhg:
        return 1;
    }
  }

  String get pressureName {
    switch (this) {
      case Pressure.hpa:
        return 'hPa';
      case Pressure.inhg:
        return 'InHg';
    }
  }

  double convertPressture(int pressure) {
    switch (this) {
      case Pressure.hpa:
        return (pressure).toDouble();
      case Pressure.inhg:
        return (pressure.toDouble()) / 33.86388667;
    }
  }
}
