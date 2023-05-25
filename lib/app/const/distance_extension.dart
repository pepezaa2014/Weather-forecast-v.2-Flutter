enum Distance {
  km,
  mi,
}

extension DistanceExtension on Distance {
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
