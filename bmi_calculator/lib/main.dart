import 'package:bmi_calculator/services/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthProvider().user)
      ],
      child: MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        theme: ThemeData(
          primaryColor: Color(0XFF333333),
          accentColor: Color(0XFFffb21a),
          scaffoldBackgroundColor: Color.fromRGBO(41, 39, 40, 150.0),
          brightness: Brightness.dark,
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18),
            body2: TextStyle(fontSize: 16),
            button: TextStyle(fontWeight: FontWeight.bold),
            headline: TextStyle(fontWeight: FontWeight.bold),
            subhead: TextStyle(color: Colors.grey),
          ),
        ),
        routes: {
          "/": (context) => LoginScreen(),
          "/topics": (context) => TopicsScreen(),
          "/profile": (context) => ProfileScreen(),
          "/about": (context) => AboutScreen(),
        },
      ),
    );
  }
}
