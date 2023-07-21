import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/widget/navigate_widget.dart';
import 'package:weather_app/widget/weather_days_widget.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel weatherData;

  const LocationScreen({super.key, required this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late int temp;
  late String cityName;
  late String icon;
  late String description;
  late String image;

  void updateUi() {
    temp = widget.weatherData.temp.toInt();
    cityName = widget.weatherData.name;
    icon = widget.weatherData.getWeatherIcon();
    description = widget.weatherData.getMessage();
    image = widget.weatherData.getImage();
  }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1), BlendMode.dstATop),
                ),
              ),
              constraints: const BoxConstraints.expand(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.3)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(35)),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await widget.weatherData
                                .getCurrentLocationWeather();
                            await widget.weatherData
                                .getCurrentLocationWeatherFiveDays();

                            navigatePushReplacement(
                                context: context,
                                nextScreen: LocationScreen(
                                  weatherData: widget.weatherData,
                                ));
                          },
                          child: const Icon(
                            Icons.near_me,
                            size: 34.0,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(35)),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CityScreen(
                                      weatherData: widget.weatherData,
                                    )));
                          },
                          child: const Icon(
                            Icons.location_city,
                            size: 34 - .0,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      cityName,
                      style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(35)),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                icon,
                                style: const TextStyle(fontSize: 40),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                temp.toString(),
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(35)),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer_sharp,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '${TimeOfDay.now().hour} : ${TimeOfDay.now().minute}',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.keyboard_double_arrow_left_outlined),
                      Spacer(),
                      Icon(Icons.keyboard_double_arrow_right_outlined),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return WeatherDaysWidget(
                              weatherData: widget.weatherData, index: index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
