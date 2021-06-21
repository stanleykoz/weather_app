import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/networking/api_provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/horizontal_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentlySelected = 0;

  void _selectItem(int selectedItem) {
    setState(() {
      currentlySelected = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return APIProvider.apiProvider.fetchWeatherFromServer();
        },
        child: FutureBuilder(
          future: APIProvider.apiProvider.fetchWeatherFromServer(),
          builder: (context, AsyncSnapshot<WeatherResponse> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        snapshot.data.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              snapshot
                                  .data.wheatherList[currentlySelected].name,
                            ),
                            Image.network(
                                "https://www.metaweather.com/static/img/weather/png/${snapshot.data.wheatherList[currentlySelected].image}.png"),
                            Text(
                              snapshot.data.wheatherList[currentlySelected]
                                  .currentTemp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: HorizontalList(
                        weatherList: snapshot.data.wheatherList,
                        selectItem: _selectItem,
                      )),
                ],
              );
            } else
              return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
