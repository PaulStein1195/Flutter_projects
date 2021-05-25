import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/Floating_create/add_activity.dart';
import 'package:bonfire_newbonfire/screens/Floating_create/create_post.dart';
import 'package:bonfire_newbonfire/screens/display_post_page.dart';
import 'package:bonfire_newbonfire/screens/Access/my_onboard_animation.dart';
import 'package:bonfire_newbonfire/screens/Access/register_1_screen.dart';
import 'package:bonfire_newbonfire/test/choose_bonfire_screen.dart';
import 'package:bonfire_newbonfire/screens/Access/onboarding_screens.dart';
import 'package:bonfire_newbonfire/screens/Profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/screens/Access/confirmation_email.dart';
import 'package:bonfire_newbonfire/screens/Profile/profile_screen.dart';
import 'package:bonfire_newbonfire/home_screen.dart';
import 'package:bonfire_newbonfire/screens/Access/login_screen.dart';
import 'package:bonfire_newbonfire/screens/Access/welcome_screen.dart';
import 'package:bonfire_newbonfire/service/navigation_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (BuildContext context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.instance.navigatorKey,
        theme: ThemeData(
          primaryColor: Color(0XFF333333),
          accentColor: Color(0XFFffb21a),
          scaffoldBackgroundColor: kFirstBackgroundColor, // Color(0XFF232020),//Color.fromRGBO(41, 39, 40, 180.0),
          fontFamily: "Palanquin",

        ),
        initialRoute: "splash",
        routes: {
          "splash": (BuildContext _context) => SplashScreen(),
          "login": (BuildContext _context) => LoginScreen(),
          "register": (BuildContext _context) => Register1_Screen(),
          "welcome": (BuildContext _context) => WelcomeScreen(),
          "home": (BuildContext _context) => HomeScreen(),
          "timeline": (BuildContext _context) => HomePage(),
          "email_verification": (BuildContext _context) => EmailVerification(),
          "profile": (BuildContext _context) => ProfileScreen(),
          "edit_profile": (BuildContext _context) => EditProfile(),
          "create_post": (BuildContext _context) => CreatePostPage(),
          "select_type_post": (BuildContext _context) => SelectPost(),
          "bonfire_options": (BuildContext _context) => ChooseBonfireScreen(),
          "guide": (BuildContext _context) => Onboard1(),
        },
      ),
    );
  }
}
