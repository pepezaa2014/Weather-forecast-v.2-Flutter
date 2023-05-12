enum Temperature {
  celcius,
  fahrenheit,
  kelvin,
}

extension TempearatueExtension on Temperature {
  int get keyValue {
    switch (this) {
      case Temperature.celcius:
        return 0;
      case Temperature.fahrenheit:
        return 1;
      case Temperature.kelvin:
        return 2;
    }
  }

  String get tempName {
    switch (this) {
      case Temperature.celcius:
        return '°C';
      case Temperature.fahrenheit:
        return '°F';
      case Temperature.kelvin:
        return 'K';
    }
  }

  double convertTemp(double tempInKelvin) {
    switch (this) {
      case Temperature.celcius:
        return tempInKelvin - 273;
      case Temperature.fahrenheit:
        return (tempInKelvin - 273.15) * 9 / 5 + 32;
      case Temperature.kelvin:
        return tempInKelvin;
    }
  }
}
