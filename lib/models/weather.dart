import 'package:flutter/cupertino.dart';

class WeatherResponse {
  final String title;
  final List<Weather> wheatherList;

  WeatherResponse({this.title, this.wheatherList});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      new WeatherResponse(
        title: json['title'],
        wheatherList: List<Weather>.from(
          json['consolidated_weather'].map(
            (weather) => Weather.fromJson(weather),
          ),
        ),
      );
}

class Weather {
  final DateTime date;
  final String name;
  final String image;
  final String currentTemp;
  final String maxTemp;
  final String minTemp;
  final String humidity;
  final String pressure;
  final String wind;

  Weather({
    @required this.date,
    @required this.name,
    @required this.image,
    @required this.currentTemp,
    @required this.minTemp,
    @required this.maxTemp,
    @required this.humidity,
    @required this.pressure,
    @required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => new Weather(
        name: json['weather_state_name'].toString(),
        date: DateTime.parse(json['applicable_date']),
        currentTemp: json['the_temp'].toString(),
        minTemp: json['min_temp'].toString(),
        maxTemp: json['max_temp'].toString(),
        humidity: json['humidity'].toString(),
        pressure: json['air_pressure'].toString(),
        wind: json['wind_speed'].toString(),
        image: json['weather_state_abbr'].toString(),
      );
}
