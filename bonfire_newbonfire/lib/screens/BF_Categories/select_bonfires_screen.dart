import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/BF_Categories/technology.dart';
import 'package:bonfire_newbonfire/widget/bonfire_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../my_flutter_app_icons.dart';
import 'arts.dart';
import 'health.dart';
import 'nature.dart';

AuthProvider _auth;

class SelectBonfireScreen extends StatelessWidget {
  final String arts = "Arts";
  final String education = "Education";
  final String health = "Health";
  final String nature = "Nature";
  final String tech = "Technology";
  final String other = "Other";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: AuthProvider.instance,
      child: Builder(
        builder: (BuildContext context) {
          _auth = Provider.of<AuthProvider>(context);
          return Scaffold(
              backgroundColor: Color(0XFF333333),
            //appBar: kAppbar(context),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Select Bonfires",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Avatar_Widget(context,
                          color1: Colors.lightGreenAccent,
                          color2: Colors.lightGreen.shade600,
                          text: nature,
                          icon: MyFlutterApp.earth, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Nature(
                                bonfire: nature,
                                  myUser: _auth.user?.uid
                              );
                            },
                          ),
                        );
                      }),
                      Avatar_Widget(context,
                          color1: Colors.lightBlueAccent,
                          color2: Colors.blueAccent,
                          text: tech,
                          icon: MyFlutterApp.globe, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Technology(
                                bonfire: tech,
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Avatar_Widget(context,
                          color1: Colors.amber,
                          color2: Colors.orange.shade600,
                          text: health,
                          icon: MyFlutterApp.users, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Health(
                                bonfire: health,
                              );
                            },
                          ),
                        );
                      }),
                      Avatar_Widget(context,
                          color1: Colors.redAccent,
                          color2: Colors.red.shade600,
                          text: arts,
                          icon: MyFlutterApp.users, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return BF_Arts(
                                bonfire: arts,
                              );
                            },
                          ),
                        );
                      }),
                      /*Avatar_Widget(context, text: education, icon: MyFlutterApp.book,
                    onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return BF_Education(
                          bonfire: education,
                        );
                      },
                    ),
                  );
                }),*/
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
