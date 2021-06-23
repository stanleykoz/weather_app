import 'package:http/http.dart';
import 'package:weather_app/models/weather.dart';

import 'package:rxdart/rxdart.dart';
import 'package:weather_app/repositories/repository.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherFetcher = PublishSubject<WeatherResponse>();

  WeatherResponse _weatherResponse;
  bool isRefreshing = false;

  Stream<WeatherResponse> get allWeather => _weatherFetcher.stream;

  fetchWeather() async {
    _weatherResponse = await _repository.fetchWeather();
    _weatherFetcher.sink.add(_weatherResponse);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();
