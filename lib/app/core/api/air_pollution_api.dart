import 'package:dio/dio.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/core/dio_client.dart';
import 'package:weather_v2_pepe/app/core/handle_exceptions.dart';
import 'package:weather_v2_pepe/app/core/routers/air_pollution_router.dart';
import 'package:weather_v2_pepe/app/data/models/air_pollution_model.dart';

class AirPollutionAPI {
  final DioClient _dioClient;

  AirPollutionAPI(this._dioClient);

  Future<AirPollution> getWeatherLatLon({
    required double lat,
    required double lon,
  }) async {
    try {
      final Response response = await _dioClient.get(
        AirPollutionRouter.getAirPollution,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': AppConstant.appId,
        },
      );

      return AirPollution.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }
}
