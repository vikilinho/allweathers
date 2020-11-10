import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:vweather/utils/locationhelper.dart';


const apiKey = "562a8b29fb29577b6047a1eee7b5d660";
 

List <String> cloudtext =[
  "For a second I was almost jealous of the clouds.",
  "The sun always shines above the clouds.",
  "Clouds come floating into my life, no longer to carry rain or usher storm, but to add color to my sunset sky.",

];

List <String> suntext = [
  "Keep your face to the sun and you will never see the shadows, ― Helen Keller",
  "Even for me life had its gleams of sunshine. - Charlotte Brontë, Jane Eyre",
  "What sunshine is to flowers, smiles are to humanity. These are but trifles, to be sure; but scattered along life's pathway, the good they do is inconceivable. - Joseph Addison"

];

List <String> moonText = [
 "Don't tell me the moon is shining; show me the glint of light on broken glass. ― Anton Chekhov",
 "Everyone is a moon, and has a dark side which he never shows to anybody ― Mark Twain",
 "Moonlight drowns out all but the brightest stars ― J.R.R. Tolkien, The Lord of the Rings"
];
class WeatherData {
  
  String moonT = moonText[new Random().nextInt(moonText.length)];
  String sunT = suntext[new Random().nextInt(suntext.length)];
  String cloudT = cloudtext[new Random().nextInt(cloudtext.length)];


  LocationHelper locationData;
  int currentTemperature;
  int currentCondition;

  WeatherData({@required this.locationData});
  Future<void> getCurrentTemperature() async {
    Response response = await get(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric');
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      print(response.body);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition != null && currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: Icon(
          FontAwesomeIcons.cloud,
          size: 75.0,
        ),
        weatherImage: AssetImage('images/finegirl.jpg'),
        weathertext: cloudT);

      
    } else {
      var now = new DateTime.now();
      if (now.hour >= 20) {
        return WeatherDisplayData(
            weatherIcon: Icon(FontAwesomeIcons.moon, size: 75.0,
            color: Colors.white,),
            weatherImage: AssetImage('images/fineboy.jpg'),
            weathertext: moonT); 
      }
        else {
          return WeatherDisplayData (
            weatherImage: AssetImage('images/both.jpg', ),
            weatherIcon: Icon(FontAwesomeIcons.sun,
            size: 75.0,
          color: Colors.white,),
          weathertext: sunT,
          );
        }
    }
  }
}

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  String weathertext;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage, @required this.weathertext});
}
