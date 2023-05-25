enum Precipitation {
  mm,
  inn,
}

extension PrecipitationExtension on Precipitation {
  String get precipitationName {
    switch (this) {
      case Precipitation.mm:
        return 'mm';
      case Precipitation.inn:
        return 'in';
    }
  }

  double convertPrecipitation(double precipitation) {
    switch (this) {
      case Precipitation.mm:
        return precipitation;
      case Precipitation.inn:
        return precipitation * 0.03937008;
    }
  }
}
