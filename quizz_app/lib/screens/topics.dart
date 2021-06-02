import 'package:flutter/material.dart';
import 'package:quizz_app/shared/bottom_nav.dart';

class TopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("topics"),
      ),
      body: Center(
        child: Text("Adding topics screen"),
      ),
        bottomNavigationBar: OurAppBottomNav(),
    );
  }
}
