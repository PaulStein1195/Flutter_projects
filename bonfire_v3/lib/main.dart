// @dart=2.9
import 'package:bomfire_v3/screens/Access/splashPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black87, // status bar color
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bonfire',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.grey.shade900,//Color.fromRGBO(41, 39, 40, 150.0),
        primaryColorDark: Colors.grey.shade900, //Color.fromRGBO(41, 39, 40, 150.0),
        primaryColorLight: Color(0XFFf2f2f7),
        buttonColor: Colors.orange,
        primaryColor: Color(0XFF333333),
        accentColor: Color(0XFFffb21a),
        dividerColor: Colors.orange,
        fontFamily: "Palanquin",
      ),
      home: SplashPage(),
    );
  }


}

