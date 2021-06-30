
import 'package:bomfire_v3/screens/WH.dart';
import 'package:flutter/material.dart';
import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:get/get.dart';
import '../my_flutter_app_icons.dart';
import 'Bonfire/bonfire_screen.dart';
import 'Profile/profile.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ThemeController themeController = Get.put(ThemeController());
  final ThemeController themeCont = Get.put(ThemeController());
  bool themeVal = true;

  List<Widget> _widgetOptions = <Widget>[
    WHScreen(),
    BonfiresScreen(),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        backgroundColor: themeController.theme.value == "dark"
            ? Colors.black.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
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
        selectedItemColor: themeCont.theme.value == "dark"
            ? Get.theme.primaryColorLight
            : Get.theme.primaryColorDark,
        unselectedItemColor: themeCont.theme.value == "dark"
            ? Get.theme.primaryColorLight
            : Get.theme.primaryColorDark,
        onTap: _onItemTapped,
      ),
    );
  }
}
