import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/widget/navigate_widget.dart';

class CityScreen extends StatefulWidget {
  final WeatherModel weatherData;

  const CityScreen({super.key, required this.weatherData});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  late String cityName;
  GlobalKey<FormState> formKey = GlobalKey();

  Future getCityWeatherData() async {
    await widget.weatherData.getCityLocationWeather(cityName);
    await widget.weatherData.getCitytLocationWeatherFiveDays(cityName);

    navigatePushReplacement(
        context: context,
        nextScreen: LocationScreen(
          weatherData: widget.weatherData,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("city name",
            style: TextStyle(
              fontSize: 28,
            )),
        centerTitle: true,
        backgroundColor: Colors.purple.withOpacity(0.9),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  style: TextStyle(color: Colors.purple.withOpacity(0.9)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a City ";
                    }
                    cityName = value;
                    return null;
                  },
                  decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Colors.purple.withOpacity(0.9)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.9))),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                      label: const Text("Enter your city name")),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await getCityWeatherData();
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: const Text(
                'Get Weather',
                style: kButtonTextStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
