import 'package:bmi_calculator/shared/bottom_nav.dart';
import 'package:flutter/material.dart';

class TopicsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("topics"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(child: Text("Topics")),
      bottomNavigationBar: OurBottomNavigation(),
    );
  }
}
