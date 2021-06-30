// @dart=2.9

import 'package:bomfire_v3/view/splashPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire camp',
      theme: ThemeData(
        primaryColor: Color(0xfffb702a),
        accentColor: Color(0xfffdc528),
        focusColor: Colors.white,
        cardColor: Colors.black,
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashPage(),
    );
  }


}

