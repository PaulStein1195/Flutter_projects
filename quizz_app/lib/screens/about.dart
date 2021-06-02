import 'package:flutter/material.dart';
import 'package:quizz_app/shared/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("about"),
      ),
      body: Center(
        child: Text("Adding about screen"),
      ),
      bottomNavigationBar: OurAppBottomNav(),

    );
  }
}
