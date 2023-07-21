import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class WeatherDaysWidget extends StatefulWidget {
  WeatherModel weatherData;
  int index;

  WeatherDaysWidget({Key? key, required this.weatherData, required this.index})
      : super(key: key);

  @override
  State<WeatherDaysWidget> createState() => _WeatherDaysWidgetState();
}

class _WeatherDaysWidgetState extends State<WeatherDaysWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.weatherData.date[widget.index],
              style: const TextStyle(color: Colors.black, fontSize: 20 , fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8,),
            Text(
              widget.weatherData.iconList[widget.index],
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8,),
            Text(
              widget.weatherData.tempList[widget.index].toStringAsFixed(0),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
