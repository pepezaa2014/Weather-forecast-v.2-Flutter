enum AQI {
  good,
  fair,
  moderate,
  poor,
  veryPoor,
}

extension AQIExtension on AQI {
  int get keyValue {
    switch (this) {
      case AQI.good:
        return 1;
      case AQI.fair:
        return 2;
      case AQI.moderate:
        return 3;
      case AQI.poor:
        return 4;
      case AQI.veryPoor:
        return 5;
    }
  }

  String get detail {
    switch (this) {
      case AQI.good:
        return 'Good';
      case AQI.fair:
        return 'Fair';
      case AQI.moderate:
        return 'Moderate';
      case AQI.poor:
        return 'Poor';
      case AQI.veryPoor:
        return 'Very Poor';
    }
  }
}
