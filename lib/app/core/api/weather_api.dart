import 'package:dio/dio.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/core/dio_client.dart';
import 'package:weather_v2_pepe/app/core/handle_exceptions.dart';
import 'package:weather_v2_pepe/app/core/routers/air_pollution_router.dart';
import 'package:weather_v2_pepe/app/core/routers/future_weather_router.dart';
import 'package:weather_v2_pepe/app/core/routers/geocoding_router.dart';
import 'package:weather_v2_pepe/app/core/routers/weather_router.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';

import 'package:weather_v2_pepe/app/data/models/weather_model.dart';

class WeatherAPI {
  final DioClient _dioClient;
  WeatherAPI(this._dioClient);

  Future<Weather> getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final Response response = await _dioClient.get(
        WeatherRouter.getWeather,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': AppConstant.appId,
        },
      );

      return Weather.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }

  Future<Weather> getWeatherCity({
    required String city,
  }) async {
    try {
      final Response response = await _dioClient.get(
        WeatherRouter.getWeather,
        queryParameters: {
          'q': city,
          'appid': AppConstant.appId,
        },
      );

      return Weather.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }
}
