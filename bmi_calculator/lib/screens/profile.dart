import 'package:bmi_calculator/services/auth.dart';
import 'package:bmi_calculator/shared/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final AuthProvider auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: FlatButton(
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
          },
          child: Text("logout"),
        ),
      ),
      bottomNavigationBar: OurBottomNavigation(),
    );
  }
}
