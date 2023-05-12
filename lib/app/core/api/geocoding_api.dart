import 'package:dio/dio.dart';
import 'package:weather_v2_pepe/app/const/app_constant.dart';
import 'package:weather_v2_pepe/app/core/dio_client.dart';
import 'package:weather_v2_pepe/app/core/handle_exceptions.dart';
import 'package:weather_v2_pepe/app/core/routers/geocoding_router.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';

class GeocodingAPI {
  final DioClient _dioClient;

  GeocodingAPI(this._dioClient);

  Future<Geocoding> getWeatherCity({
    required String city,
  }) async {
    try {
      final Response response = await _dioClient.get(
        GeocodingRouter.geocodingURL,
        queryParameters: {
          'q': city,
          'limit': AppConstant.limitGeocoding,
          'appid': AppConstant.appId,
        },
      );

      return Geocoding.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }
}
