import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:flutter/material.dart';

Widget Amber_Btn_Widget(
    {BuildContext context, String text, Function onPressed}) {
  return Material(
    color: Colors.orange.shade600,//Theme.of(context).accentColor,
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    elevation: 2.0,
    child: MaterialButton(
      onPressed: onPressed,
      minWidth: 100.0,
      child: Text(
          text,
          style: TextStyle(
              letterSpacing: 0.3,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: kMainBoxColor),
        ),
    ),
  );
}
