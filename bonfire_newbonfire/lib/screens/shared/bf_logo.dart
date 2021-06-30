import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class OurSquareBF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(8, 2, 10, 5),
      child: Row(
        children: [
          OurSquare("Social", MyFlutterApp.sound),
          OurSquare("Cripto", MyFlutterApp.bitcoin),
          OurSquare("Economics", MyFlutterApp.money),
          OurSquare("Science", MyFlutterApp.beaker),
          OurSquare("Space", MyFlutterApp.rocket),
          OurSquare("Software", MyFlutterApp.laptop),
          OurSquare("Music", MyFlutterApp.music),
          //OurSquare("Travel", MyFlutterApp.earth),
          OurSquare("More", Icons.add),


        ],
      ),
    );
  }
}

Widget OurSquare(
  String _name,
  IconData _icon,
) {
  return Padding(
    padding: const EdgeInsets.only(right: 18.0),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(_icon, size: 30.0, color: Colors.white,),
          ),
        ),
        Text(_name, style: TextStyle( fontSize: 17.0),)
      ],
    ),
  );
}
