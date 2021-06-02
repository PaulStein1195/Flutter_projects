import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/services/auth.dart';
import 'package:quizz_app/shared/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  final AuthProvider auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("profile - ${user.displayName}"),
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
      bottomNavigationBar: OurAppBottomNav(),
    );
  }
}
