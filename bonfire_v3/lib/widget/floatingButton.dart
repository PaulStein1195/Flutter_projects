import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:bomfire_v3/screens/Float_btn/create_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_flutter_app_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

bool themeVal = true;
final ThemeController themeController = Get.put(ThemeController());


Widget kFloatingAction(BuildContext context) {
  return SpeedDial(
    buttonSize: 75.0,
    marginEnd: 20,
    marginBottom: 20,
    overlayColor: themeController.theme.value == "dark"
        ? Colors.white24
        : Colors.black45,
    backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
    animatedIcon: AnimatedIcons.add_event,
    children: [
      SpeedDialChild(
        labelBackgroundColor: Colors.transparent,
        child: Icon(MyFlutterApp.fire_1, color: Colors.orange, size: 30.0),
        backgroundColor: themeController.theme.value == "dark"
            ? Colors.black.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        label: 'Bonfire',
        labelStyle: TextStyle(fontSize: 18.0, color: Colors.white70),
        onTap: () => print('FIRST CHILD'),
        onLongPress: () => print('FIRST CHILD LONG PRESS'),
      ),
      SpeedDialChild(
        labelBackgroundColor: Colors.transparent,
        child: Icon(
          MyFlutterApp.pencil,
          color: Colors.orange,
          size: 30.0,
        ),
        backgroundColor: themeController.theme.value == "dark"
  ? Colors.black.withOpacity(0.9)
      : Colors.white.withOpacity(0.9),
        label: 'Post',
        labelStyle: TextStyle(fontSize: 18.0, color: Colors.white70),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => CreatePostScreen())),
        onLongPress: () => print('SECOND CHILD LONG PRESS'),
      ),
    ],
  );
}