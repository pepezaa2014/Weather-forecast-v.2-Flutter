import 'package:dio/dio.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/core/dio_client.dart';
import 'package:weather_v2_pepe/app/core/handle_exceptions.dart';
import 'package:weather_v2_pepe/app/core/routers/future_weather_router.dart';
import 'package:weather_v2_pepe/app/data/models/future_weather_model.dart';

class FutureWeatherAPI {
  final DioClient _dioClient;

  FutureWeatherAPI(this._dioClient);

  Future<FutureWeather> getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final Response response = await _dioClient.get(
        FutureWeatherRouter.getFutureWeather,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': AppConstant.appId,
        },
      );

      return FutureWeather.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }

  Future<FutureWeather> getWeatherId({
    required int id,
  }) async {
    try {
      final Response response = await _dioClient.get(
        FutureWeatherRouter.getFutureWeather,
        queryParameters: {
          'id': id,
          'appid': AppConstant.appId,
        },
      );

      return FutureWeather.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }
}
