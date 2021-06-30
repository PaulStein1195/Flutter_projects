import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ThemeController themeCont = Get.put(ThemeController());

Widget TabTitle(String title) {
  return Tab(
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 19,
          color: themeCont.theme.value == "dark"
              ? Colors.white
              : Colors.grey[800],
          fontWeight: FontWeight.w700),
    ),
  );
}