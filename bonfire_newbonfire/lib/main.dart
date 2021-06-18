import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/Float_btn/create_post.dart';
import 'package:bonfire_newbonfire/screens/Home/calendar.dart';
import 'package:bonfire_newbonfire/screens/Home/homepage(test).dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/service/navigation_service.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black87, // status bar color
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.instance.navigatorKey,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0XFF333333),
            accentColor: Color(0XFFffb21a),
            scaffoldBackgroundColor: kFirstBackgroundColor,
            // Color(0XFF232020),//Color.fromRGBO(41, 39, 40, 180.0),
            fontFamily: "Palanquin",
            textTheme: TextTheme(
                //headline1: TextStyle()
                )),
        initialRoute: "splash",
        routes: {
          "splash": (BuildContext _context) => SplashScreen(),
          "login": (BuildContext _context) => LoginScreen(),
          "register": (BuildContext _context) => Register2Screen(),
          "welcome": (BuildContext _context) => WelcomeScreen(),
          "home": (BuildContext _context) => HomeScreen(),
          "timeline": (BuildContext _context) => HomepageScreen(),
          "email_verification": (BuildContext _context) =>
              EmailVerificationScreen(),
          "calendar": (BuildContext _context) => CalendarScreen(),
          "profile": (BuildContext _context) => ProfileScreen(),
          "edit_profile": (BuildContext _context) => EditProfile(),
          "create_post": (BuildContext _context) => CreatePostScreen(),
          "select_type_post": (BuildContext _context) => PickActivityScreen(),
          "guide": (BuildContext _context) => Onboard1(),
        },
      ),
    );
  }
}
