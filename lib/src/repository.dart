import 'package:weather/src/services.dart';

import 'models.dart';

abstract class IWeatherRepository {
  Future<CityInfo> getWeather(String city, {String key});
}

class WeatherRepository implements IWeatherRepository {
  final IHttpClient service;
  const WeatherRepository({this.service = const HttpClientService()});

  Future<CityInfo> getWeather(String city,
      {key = 'b8f9be6a0a5a5800fe6264b93564121c'}) async {
    final queryParameters = {
      'q': city,
      'appid': key,
      'units': 'metric',
    };

    final uri = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      queryParameters,
    );

    final response = await service.get(uri);

    return CityInfo.fromJson(response.body);
  }
}
