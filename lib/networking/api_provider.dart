import 'dart:convert';
import 'dart:io';

import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

class APIProvider {
  static final APIProvider apiProvider = APIProvider._();

  final String _baseUrl = "https://www.metaweather.com/api/";

  APIProvider._();

  Future<WeatherResponse> fetchWeatherFromServer() async {
    final response = await http.get(
      Uri.parse(_baseUrl + "location/44418/"),
    );

    assert(response.statusCode == HttpStatus.ok);
    final jsonData = json.decode(response.body);

    return WeatherResponse.fromJson(jsonData);
  }

  Future<Weather> fetchWeatherForDay(DateTime date) async {
    final response = await http.get(
      Uri.parse(_baseUrl +
          "location/44418/${date.year.toString()}/${date.month.toString()}/${date.day.toString()}"),
    );

    assert(response.statusCode == HttpStatus.ok);
    final jsonData = json.decode(response.body);

    Weather weatherResponse =
        jsonData.map((weather) => Weather.fromJson(weather));

    return weatherResponse;
  }
}
