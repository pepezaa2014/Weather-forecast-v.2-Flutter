import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_v2_pepe/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(ImageName.barometer).existsSync(), true);
    expect(File(ImageName.humidity).existsSync(), true);
    expect(File(ImageName.sunrise).existsSync(), true);
    expect(File(ImageName.sunset).existsSync(), true);
    expect(File(ImageName.weather01d).existsSync(), true);
    expect(File(ImageName.weather01n).existsSync(), true);
    expect(File(ImageName.weather02d).existsSync(), true);
    expect(File(ImageName.weather02n).existsSync(), true);
    expect(File(ImageName.weather03d).existsSync(), true);
    expect(File(ImageName.weather03n).existsSync(), true);
    expect(File(ImageName.weather04d).existsSync(), true);
    expect(File(ImageName.weather04n).existsSync(), true);
    expect(File(ImageName.weather09d).existsSync(), true);
    expect(File(ImageName.weather09n).existsSync(), true);
    expect(File(ImageName.weather10d).existsSync(), true);
    expect(File(ImageName.weather10n).existsSync(), true);
    expect(File(ImageName.weather11d).existsSync(), true);
    expect(File(ImageName.weather11n).existsSync(), true);
    expect(File(ImageName.weather13d).existsSync(), true);
    expect(File(ImageName.weather13n).existsSync(), true);
    expect(File(ImageName.weather50d).existsSync(), true);
    expect(File(ImageName.weather50n).existsSync(), true);
    expect(File(ImageName.wind).existsSync(), true);
  });
}
