import 'package:flutter/material.dart';
import 'package:udem_post/screens/home.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrOpinion',
      theme: ThemeData(
          fontFamily: "PT-Sans",
          backgroundColor: Colors.white,
          primaryColor: Color(0xFF10375c),
          accentColor: Color(0xFFffa41b),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Color(0xFF428DFF),
          dividerColor: Color(0xFF071a52),
          toggleableActiveColor: Color(0xFF071a52)
      ),
      home: Home(),
    );
  }
}
