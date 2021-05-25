import 'package:flutter/material.dart';

import '../my_flutter_app_icons.dart';

const kFirstAppbarColor = Color.fromRGBO(41, 39, 40, 180.0);//Color.fromRGBO(41, 39, 40, 200.0);
const kFirstBackgroundColor = Color.fromRGBO(41, 39, 40, 150.0);
const kMainBoxColor = Color(0XFF292728);
const kAmberColor = Color(0XFFffb21a);


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
  return FloatingActionButton(
    elevation: 5.0,
    backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
    child:
    Icon(Icons.add, size: 25.0, color: Colors.white70, //Color(0XFF333333)
    ),
    onPressed: () => Navigator.pushNamed(context, "select_type_post"),
  );
}

