import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/user_access/widgets/amber_btn_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'model/notifications.dart';

int notifications_count = 0;
AuthProvider _auth;
FirebaseUser user;

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  getActivityFeed() async {
    QuerySnapshot _snapshot = await Firestore.instance
        .collection("Notifications")
        .document(user.uid)
        .collection("notificationsItems")
        .orderBy('timestamp', descending: true)
        .limit(50)
        .getDocuments();
    _snapshot.documents.forEach((element) {
      print("Notification: ${element.data}");
    });
    return _snapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 39, 40, 180.0),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications", style: TextStyle(color: Colors.white70),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
          future: getActivityFeed(),
          builder: (context, _snapshot) {
            if(!_snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kAppbarColor,
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 30.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MyFlutterApp.alarm,
                                color: Colors.white70,
                                size: 70.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "No Notifications",
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Stay active and be fire!",
                                style: TextStyle(fontSize: 28.0, color: kAmberColor),
                              ),

                              /*Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/Logo.png")
                                )
                            ),
                          ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Amber_Btn_Widget(
                    context: context,
                    text: "GO BACK",
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            }
            return Text("");
          },
        )
      ),
    );
  }
}


class NotificationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
