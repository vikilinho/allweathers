import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:location/location.dart';
import 'package:vweather/main_screen.dart';
import 'package:vweather/utils/locationhelper.dart';
import 'package:vweather/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getWeatherData() async  {
    // Fetch the location
  await getLocationData();
  // Fetch the current weather
  WeatherData weatherData = WeatherData(locationData: locationData);
  await weatherData.getCurrentTemperature();
  if (weatherData.currentTemperature == null ||
      weatherData.currentCondition == null) {
    // todo: Handle no weather
  }
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
    return MainScreen( weatherData: weatherData,);
  }));
  }
LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
  await locationData.getCurrentLocation();
   if (locationData.latitude == null || locationData.longitude == null) {
    // todo: Handle no location
  }
  // print(locationData.longitude);
  // print(locationData.latitude);
  }
  @override
  void initState() {
    
    super.initState();
    getWeatherData();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.indigo]
          ),
        ),
        child: Center(
          child: SpinKitRipple(color: Colors.white,
          size: 150,
          duration: Duration(milliseconds:1200 ),),
        )
      ),
    );
  }
}