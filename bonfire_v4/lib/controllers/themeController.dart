import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController{
  var theme="dark".obs;
  Future<void> ChangeTheme(var p1) async {
    //change theme value and then store current theme value to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(p1=="dark")
      {
        theme="dark".obs;
        prefs.setString('theme', "dark");
      }
    else{
      theme="light".obs;
      prefs.setString('theme', "light");
    }
  }
}