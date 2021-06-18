import 'package:bmi_calculator/shared/bottom_nav.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("about"),
        backgroundColor: Colors.blue,
      ),
      body: Center(child: Text("About")),
      bottomNavigationBar: OurBottomNavigation(),
    );
  }
}
