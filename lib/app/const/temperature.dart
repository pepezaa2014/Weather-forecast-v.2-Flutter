enum Temperature {
  celcius,
  fahrenheit,
  kelvin,
}

extension TempearatueExtension on Temperature {
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

  double convertTemperature(double tempInKelvin) {
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
