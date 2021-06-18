import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OurBottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.graduationCap,
            size: 20,
          ),
          title: Text("Topics"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.bolt,
            size: 20,
          ),
          title: Text("About"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.personBooth,
            size: 20,
          ),
          title: Text("Profile"),
        ),
      ].toList(),
      //fixedColor: Colors.grey,
      selectedItemColor: Colors.amber,
      onTap: (int idx) {
        switch(idx) {
          case 0:
            //Navigator.pushNamed(context, "/topics");
            break;
          case 1:
            Navigator.pushNamed(context, "/about");
            break;
          case 2:
            Navigator.pushNamed(context, "/profile");
            break;
        }
      },
    );
  }
}
