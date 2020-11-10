import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vweather/loading_screen.dart';


void main() {
  var rng = new Random(); 
 for (var i = 0; i < 10; i++) {
    print(rng.nextInt(4));
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    darkTheme: ThemeData.dark()
  ));
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:LoadingScreen(),
    );
  }
}

