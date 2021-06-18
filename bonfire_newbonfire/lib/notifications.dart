import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/Access/widgets/amber_btn_widget.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'model/notifications.dart';

int notifications_count = 0;
AuthProvider _auth;
FirebaseUser user;

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: AuthProvider.instance,
      child: Builder(builder: (BuildContext context) {
        _auth = Provider.of<AuthProvider>(context);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: kFirstAppbarColor,
              centerTitle: true,
              title: Text(
                "Notifications",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: StreamBuilder<List<NotificationItem>>(
                stream: DBService.instance.getNotificationsItem(_auth.user.uid),
                builder: (BuildContext context, snapshot) {
                  var _data = snapshot.data;
                  print("value data " + _data.toString());

                  if (_data.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Container(
                            height: 250.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                color: kFirstAppbarColor,
                                border: Border.all(color: Colors.white38),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    MyFlutterApp.bell,
                                    color: Colors.white70,
                                    size: 70.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Notifications",
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Empty!",
                                        style: TextStyle(
                                            fontSize: 28.0, color: kAmberColor),
                                      ),
                                    ],
                                  )

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
                        Amber_Btn_Widget(
                            context: context,
                            text: "GO BACK",
                            onPressed: () => Navigator.pop(context))
                      ],
                    );
                  } else if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kAmberColor,
                      ),
                    );
                  }
                  else {
                    return ListView(
                      children: snapshot.data,
                    );
                  }
                },
              ),
            ));
      }),
    );
  }
}

/*

*/
