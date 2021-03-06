import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';

class HorizontalList extends StatefulWidget {
  final List<Weather> weatherList;
  final Function selectItem;

  HorizontalList({
    this.weatherList,
    this.selectItem,
  });

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  int currentlySelected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.weatherList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                currentlySelected = index;
              });
              widget.selectItem(currentlySelected);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: currentlySelected == index ? 4 : 2,
                  color:
                      currentlySelected == index ? Colors.green : Colors.black,
                ),
              ),
              height: 60,
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        DateFormat('EEEE')
                            .format(widget.weatherList[index].date),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network(
                        "https://www.metaweather.com/static/img/weather/png/${widget.weatherList[index].image}.png"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "${widget.weatherList[index].minTemp.substring(0, 4)}/${widget.weatherList[index].maxTemp.substring(0, 4)} ??C",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
