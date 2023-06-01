import 'package:weather_v2_pepe/resources/resources.dart';

enum WeatherIcon {
  weather01d,
  weather01n,
  weather02n,
  weather02d,
  weather03n,
  weather03d,
  weather04n,
  weather04d,
  weather09n,
  weather09d,
  weather10n,
  weather10d,
  weather11n,
  weather11d,
  weather13n,
  weather13d,
  weather50n,
  weather50d,
}

extension WeatherIconExtension on WeatherIcon {
  String get keyValue {
    switch (this) {
      case WeatherIcon.weather01d:
        return '01d';
      case WeatherIcon.weather01n:
        return '01n';
      case WeatherIcon.weather02d:
        return '02d';
      case WeatherIcon.weather02n:
        return '02n';
      case WeatherIcon.weather03d:
        return '03d';
      case WeatherIcon.weather03n:
        return '03n';
      case WeatherIcon.weather04d:
        return '04d';
      case WeatherIcon.weather04n:
        return '04n';
      case WeatherIcon.weather09d:
        return '09d';
      case WeatherIcon.weather09n:
        return '09n';
      case WeatherIcon.weather10d:
        return '10d';
      case WeatherIcon.weather10n:
        return '10n';
      case WeatherIcon.weather11d:
        return '11d';
      case WeatherIcon.weather11n:
        return '11n';
      case WeatherIcon.weather13d:
        return '13d';
      case WeatherIcon.weather13n:
        return '13n';
      case WeatherIcon.weather50d:
        return '50d';
      case WeatherIcon.weather50n:
        return '50n';
    }
  }

  String get imageName {
    switch (this) {
      case WeatherIcon.weather01d:
        return ImageName.weather01d;
      case WeatherIcon.weather01n:
        return ImageName.weather01n;
      case WeatherIcon.weather02d:
        return ImageName.weather02d;
      case WeatherIcon.weather02n:
        return ImageName.weather02n;
      case WeatherIcon.weather03d:
        return ImageName.weather03d;
      case WeatherIcon.weather03n:
        return ImageName.weather03n;
      case WeatherIcon.weather04d:
        return ImageName.weather04d;
      case WeatherIcon.weather04n:
        return ImageName.weather04n;
      case WeatherIcon.weather09d:
        return ImageName.weather09d;
      case WeatherIcon.weather09n:
        return ImageName.weather09n;
      case WeatherIcon.weather10d:
        return ImageName.weather10d;
      case WeatherIcon.weather10n:
        return ImageName.weather10n;
      case WeatherIcon.weather11d:
        return ImageName.weather11d;
      case WeatherIcon.weather11n:
        return ImageName.weather11n;
      case WeatherIcon.weather13d:
        return ImageName.weather13d;
      case WeatherIcon.weather13n:
        return ImageName.weather13n;
      case WeatherIcon.weather50d:
        return ImageName.weather50d;
      case WeatherIcon.weather50n:
        return ImageName.weather50n;
    }
  }
}
