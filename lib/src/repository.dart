import 'package:http/http.dart' as http;
import 'models.dart';

class WeatherRepository {
  Future<CityInfo> getWeather(String city,
      [key = 'b8f9be6a0a5a5800fe6264b93564121c']) async {
    final queryParameters = {'q': city, 'appid': key, 'units': 'metric'};

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    return CityInfo.fromJson(response.body);
  }
}
