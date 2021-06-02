import 'package:flutter/material.dart';

class OurAppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 20.0,
        ),
        title: Text("Home"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.bolt,
          size: 20.0,
        ),
        title: Text("About"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          size: 20.0,
        ),
        title: Text("Profile"),
      ),
    ].toList(),
    fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
          switch (idx) {
            case 0:
              //Do nuttin
              break;
            case 1:
              Navigator.pushNamed(context, '/about');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
      },
    );
  }
}
