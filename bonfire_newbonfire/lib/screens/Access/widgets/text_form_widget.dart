import 'package:flutter/material.dart';

Widget Text_Form_Widget (String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w800,
        color: Colors.white),
  );
}


const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.black54),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);