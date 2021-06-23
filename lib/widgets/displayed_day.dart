import 'package:flutter/material.dart';

class DisplayedDay extends StatelessWidget {
  final String name;
  final String day;
  final String image;
  final String temp;
  final String humidity;
  final String wind;
  final String pressure;

  DisplayedDay({
    this.name,
    this.image,
    this.temp,
    this.day,
    this.humidity,
    this.wind,
    this.pressure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(
                      "https://www.metaweather.com/static/img/weather/png/$image.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "temperature: ${temp.substring(0, 4)} °C",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "humidity: $humidity %",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "wind: ${wind.substring(0, 4)} km/h",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "pressure: $pressure hPa",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
