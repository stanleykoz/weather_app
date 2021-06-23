import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_bloc.dart';

class ErrorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Something went wrong, press button to retry"),
        ElevatedButton(
          onPressed: () {
            weatherBloc.fetchWeather();
          },
          child: Text("Retry"),
        ),
      ],
    );
  }
}
