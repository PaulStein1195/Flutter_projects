import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../my_flutter_app_icons.dart';
import '../screens/Float_btn/sharein_bonfire.dart';

const kFirstAppbarColor =
    Color.fromRGBO(41, 39, 40, 180.0); //Color.fromRGBO(41, 39, 40, 200.0);
const kFirstBackgroundColor = Color.fromRGBO(41, 39, 40, 150.0);
const kMainBoxColor = Color(0XFF292728);
const kAmberColor = Color(0XFFffb21a);
const kTitlesrelevant = Color(0XFFF78C01);

Widget kAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: kFirstAppbarColor,
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

Widget kFloatingAction(BuildContext context) {
  return SpeedDial(
    buttonSize: 75.0,
    marginEnd: 20,
    marginBottom: 20,
    overlayColor: Colors.black26,
    backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
    animatedIcon: AnimatedIcons.add_event,
    children: [
      SpeedDialChild(
        labelBackgroundColor: Colors.transparent,
        child: Icon(MyFlutterApp.fire_1, color: Colors.orange, size: 30.0),
        backgroundColor: kMainBoxColor,
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
        backgroundColor: kMainBoxColor,
        label: 'Post',
        labelStyle: TextStyle(fontSize: 18.0, color: Colors.white70),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => ShareInBF())),
        onLongPress: () => print('SECOND CHILD LONG PRESS'),
      ),
      /*SpeedDialChild(
        child: Icon(Icons.keyboard_voice),
        backgroundColor: Colors.green,
        label: 'Third',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => print('THIRD CHILD'),
        onLongPress: () => print('THIRD CHILD LONG PRESS'),
      ),*/
    ],
  );
}
