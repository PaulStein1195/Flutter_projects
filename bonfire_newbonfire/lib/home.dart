import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'screens/screens.dart';


class HomeScreen extends StatefulWidget {
  final locationWeather;

  HomeScreen({this.locationWeather});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 20,
  );
  List<Widget> _widgetOptions = <Widget>[
    HomepageScreen(),
    NewBonfireScreen(),
    ProfileScreen(),
    //Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return Center(child: Text("Somethign went wrong"),);
          } else {
            return Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
          size: 28.0
      ),
      selectedIconTheme: IconThemeData(
          size: 24.0
      ),
      selectedFontSize: 17.0,
      elevation: 5.0,
      backgroundColor: Color.fromRGBO(41, 39, 40, 210.0),
      //Color.fromRGBO(108, 181, 217, 1),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.fire),
          label: "Bonfires",
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.user),
          label: "Me ",
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      onTap: _onItemTapped,
    ),);
  }
}
