import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../my_flutter_app_icons.dart';

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
  final String category;
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
    this.category,
    this.number,
    this.isRead,
    this.timestamp,
  });

  factory NotificationItem.fromDocument(DocumentSnapshot doc) {
    return NotificationItem(
      username: doc["username"],
      userId: doc["userId"],
      type: doc["type"],
      mediaUrl: doc["mediaUrl"],
      postId: doc["postId"],
      userProfileImg: doc["userProfileImg"],
      commentData: doc["commentData"],
      category: doc["category"],
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
      ActivityItemText = 'You have joined $number Bonfires in $category';
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
              children: [
                SizedBox(
                  width: 8.0,
                ),
                Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomLeft,
                      colors: [Colors.orange.shade600, Colors.orangeAccent],
                    ),
                  ),
                  child: Icon(
                    MyFlutterApp.alarm,
                    color: Colors.white70,
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  width: 8.0,
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
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                          maxLines: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            timeago.format(timestamp.toDate()),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
