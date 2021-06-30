// @dart=2.9

import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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

          scaffoldBackgroundColor: kFirstBackgroundColor,
          // Color(0XFF232020),//Color.fromRGBO(41, 39, 40, 180.0),
          primaryColorDark: Colors.grey.shade900,
          //Color.fromRGBO(41, 39, 40, 150.0),
          primaryColorLight: Color(0XFFf2f2f7),
          buttonColor: Colors.orange,
          primaryColor: Color(0XFF333333),
          accentColor: Color(0XFFffb21a),
          dividerColor: Colors.orange,
          fontFamily: "Palanquin",
        ),
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
          "select_type_post": (BuildContext _context) => PickActivityScreen(),
          "guide": (BuildContext _context) => Onboard1(),
        },
      ),
    );
  }
}
