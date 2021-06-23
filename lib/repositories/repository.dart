import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/networking/api_provider.dart';

class Repository {
  Future<WeatherResponse> fetchWeather() =>
      APIProvider.apiProvider.fetchWeatherFromServer();
}
