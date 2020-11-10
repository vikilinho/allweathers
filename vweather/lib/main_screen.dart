import 'package:flutter/material.dart';

import 'package:vweather/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  MainScreen({this.weatherData});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  String weatherText;

  void updateDisplayInfo(WeatherData weatherData) {
  setState(() {
    temperature = weatherData?.currentTemperature?.round();
    WeatherDisplayData weatherDisplayData =
        weatherData.getWeatherDisplayData();
    backgroundImage = weatherDisplayData.weatherImage;
    weatherDisplayIcon = weatherDisplayData.weatherIcon;
    weatherText = weatherDisplayData.weathertext;
  });
}

@override
  void initState() {
    
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(
              height: 35.0,
            ),
            Center(
              child: Text(
                ' $temperature°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(weatherText.toString(), style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),),
                )
            ],)

          ],
        ),
      ),
    );
  }
}
