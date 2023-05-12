enum Precipitation {
  mm,
  inn,
}

extension PrecipitationExtension on Precipitation {
  int get keyValue {
    switch (this) {
      case Precipitation.mm:
        return 0;
      case Precipitation.inn:
        return 1;
    }
  }

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
