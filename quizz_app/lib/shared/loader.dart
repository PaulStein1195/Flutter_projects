import 'package:flutter/material.dart';
import 'package:quizz_app/shared/bottom_nav.dart';

class Loader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 250.0,
      child: CircularProgressIndicator(),
    );
  }
}

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Loader()),
      bottomNavigationBar: OurAppBottomNav(),
    );
  }
}

