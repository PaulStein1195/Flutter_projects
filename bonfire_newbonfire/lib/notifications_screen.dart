import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/Access/widgets/amber_btn_widget.dart';
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
  void initState() {
    super.initState();
    getActivityFeed();
  }

  getActivityFeed() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("FeedItems")
        .document(_auth.user.uid)
        .collection("feedItems")
        .orderBy("timestamp", descending: true)
        .limit(50)
        .getDocuments();
    List<NotificationItem> notifItems = [];
    snapshot.documents.forEach((doc) {
      notifItems.add(NotificationItem.fromFirestore(doc));
      print("Hello world");
      notifications_count++;
    });

    return notifItems;
  }

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
              child: FutureBuilder(
                future: getActivityFeed(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kFirstAppbarColor,
                                border: Border.all(color: Colors.white38),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30.0, horizontal: 30.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                      style: TextStyle(
                                          fontSize: 28.0, color: kAmberColor),
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
                  return ListView(
                    children: snapshot.data,
                  );
                },
              )),
        );
      }),
    );
  }
}

Widget mediaPreview;
String ActivityItemText;

class NotificationItem extends StatelessWidget {
  final String username;
  final String userId;
  final String type;
  final String mediaUrl;
  final String postId;
  final String userProfileImg;
  final String commentData;
  final int number;
  final bool isRead;
  final Timestamp timestamp;

  NotificationItem({
    this.username,
    this.userId,
    this.type,
    this.mediaUrl,
    this.postId,
    this.userProfileImg,
    this.commentData,
    this.number,
    this.isRead,
    this.timestamp,
  });

  factory NotificationItem.fromFirestore(DocumentSnapshot doc) {
    return NotificationItem(
      username: doc["username"],
      userId: doc["userId"],
      type: doc["type"],
      mediaUrl: doc["mediaUrl"],
      postId: doc["postId"],
      userProfileImg: doc["userProfileImg"],
      commentData: doc["commentData"],
      number: doc["number"],
      isRead: doc["isRead"],
      timestamp: doc["timestamp"],
    );
  }

  configureMediaPreview(context) {
    if (type == "comment") {
      mediaPreview = GestureDetector(
        onTap: () {},
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(mediaUrl),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      mediaPreview = Text("");
    }

    if (type == "like") {
      ActivityItemText = "liked your post";
    } else if (type == "follow") {
      ActivityItemText = 'You have joined $number Bonfires in Nature';
    } else if (type == "comment") {
      ActivityItemText = "$username replied: $commentData";
    } else {
      ActivityItemText = "Error: Unknown type '$type'";
    }
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Color.fromRGBO(41, 39, 40, 10.0),
          border: Border.all(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(10.0),
          //color: Color.fromRGBO(41, 39, 40, 10.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 55.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomLeft,
                            colors: [
                              Colors.orange.shade600,
                              Colors.orangeAccent
                            ])),
                    child: Icon(
                      MyFlutterApp.alarm,
                      color: Colors.white70,
                      size: 30.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$ActivityItemText',
                            style: TextStyle(color: Colors.orange, fontSize: 16.0, fontWeight: FontWeight.w600),
                            maxLines: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              timeago.format(timestamp.toDate()),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
