import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/networking/api_provider.dart';
import 'package:intl/intl.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
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
                  child: Container(
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
                          snapshot.data.wheatherList[0].name,
                        ),
                        Text(
                          snapshot.data.wheatherList[0].currentTemp,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.wheatherList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            height: 80,
                            width: 80,
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('EEEE').format(
                                      snapshot.data.wheatherList[index].date),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${snapshot.data.wheatherList[index].minTemp.substring(0, 4)}/${snapshot.data.wheatherList[index].maxTemp.substring(0, 4)}",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
