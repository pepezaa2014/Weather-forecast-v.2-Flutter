enum Distance {
  km,
  mi,
}

extension PrecipitationExtension on Distance {
  int get keyValue {
    switch (this) {
      case Distance.km:
        return 0;
      case Distance.mi:
        return 1;
    }
  }

  String get distanceName {
    switch (this) {
      case Distance.km:
        return 'km';
      case Distance.mi:
        return 'mi';
    }
  }

  double convertDistance(int distance) {
    switch (this) {
      case Distance.km:
        return distance.toDouble() / 1000;
      case Distance.mi:
        return distance.toDouble() * 0.000621371;
    }
  }
}
