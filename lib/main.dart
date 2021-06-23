import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/networking/api_provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/displayed_day.dart';
import 'package:weather_app/widgets/error_button.dart';
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
  void initState() {
    super.initState();
    weatherBloc.fetchWeather();
  }

  @override
  void dispose() {
    super.dispose();
    weatherBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: weatherBloc.allWeather,
        builder: (context, AsyncSnapshot<WeatherResponse> snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () {
                return weatherBloc.fetchWeather();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
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
                        child: DisplayedDay(
                          name: snapshot
                              .data.wheatherList[currentlySelected].name,
                          image: snapshot
                              .data.wheatherList[currentlySelected].image,
                          temp: snapshot
                              .data.wheatherList[currentlySelected].currentTemp,
                          day: DateFormat('EEEE').format(snapshot
                              .data.wheatherList[currentlySelected].date),
                          humidity: snapshot
                              .data.wheatherList[currentlySelected].humidity,
                          pressure: snapshot
                              .data.wheatherList[currentlySelected].pressure,
                          wind: snapshot
                              .data.wheatherList[currentlySelected].wind,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: HorizontalList(
                            weatherList: snapshot.data.wheatherList,
                            selectItem: _selectItem,
                          )),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorButton(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
