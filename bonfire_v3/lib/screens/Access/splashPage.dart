import 'dart:async';
import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ConfirmNumberPage.dart';
import '../HomeScreen.dart';
import 'loginPage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{
  ThemeController themeController=Get.put(ThemeController());
  var theme="dark";

  @override
  void initState() {
    checkTheme();
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, checkLoginStatus);
  }

  checkTheme() async {
    //check theme value from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      theme=prefs.getString("theme")??"dark";
      theme=="dark"?themeController.ChangeTheme("dark"):themeController.ChangeTheme("light");
    });
  }
  void checkLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('loggedIn')??false;
    var number=prefs.getString("number")??"";
    var userID=prefs.getString("id")??"";
    //check for loggedIn status, if its false, simply goto loginPage, if its true, then check whether number is given by user or not
    if(status){
      if(number.isNotEmpty)
        {
          Get.offAll(HomeScreen(),arguments: userID);
        }
      else{
        Get.offAll(ConfirmNumberPage());
      }
    }
    else{ 
      Get.offAll(LoginPage());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:theme=="dark"?Get.theme.primaryColorDark:themeController.theme.value==""?Colors.transparent:Get.theme.primaryColorLight,
      body: Center(
        child: Image.asset("assets/images/logo.png",height: 160,)
      ),
    );
  }
}
