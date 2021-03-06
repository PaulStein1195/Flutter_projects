import 'package:flutter/material.dart';
import 'package:udem_post/Menus/Profile/profile.dart';
import 'package:udem_post/constants.dart';
import 'package:udem_post/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udem_post/screens/post_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:udem_post/widgets_global/progress.dart';
/*
int notifications_count = 0;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isLoading = false;

  getActivityFeed() async {
    QuerySnapshot snapshot = await activityFeedRef
        .document(currentUser.id)
        .collection("feedItems")
        .orderBy("timestamp", descending: true)
        .limit(50)
        .getDocuments();
    List<NotificationItem> notifItems = [];
    snapshot.documents.forEach((doc) {
      notifItems.add(NotificationItem.fromDocument(doc));
      notifications_count ++;
    });

    return notifItems;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(95.0),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              indicatorColor: Colors.amber.shade700,
              indicatorWeight: 4.0,
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "General",
                      style: kTabBarStyle
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Your activity",
                      style: kTabBarStyle
                    ),
                  ),
                ),
              ],
            ),
            title: Text("Notifications",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                ),
                overflow: TextOverflow.ellipsis),
          ),
        ),
        body: TabBarView(
          children: [
             Container(
              child: FutureBuilder(
                  future: getActivityFeed(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return circularProgress();
                    }
                    return ListView(
                      children: snapshot.data,
                    );
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: getActivityFeed(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return circularProgress();
                    }
                    return ListView(
                      children: snapshot.data,
                    );
                  }),
            ),
          ],
        )
      ),
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
  final Timestamp timestamp;

  NotificationItem({
    this.username,
    this.userId,
    this.type,
    this.mediaUrl,
    this.postId,
    this.userProfileImg,
    this.commentData,
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
      timestamp: doc["timestamp"],
    );
  }

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          postId: postId,
          userId: userId,
        ),
      ),
    );
  }

  configureMediaPreview(context) {
    if (type == "comment") {
      mediaPreview = GestureDetector(
        onTap: () => showPost(context),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(mediaUrl),
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
      ActivityItemText = "$username is following you";
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
      padding: EdgeInsets.only(top: 2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey.shade300),
            bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
          )
        ),
        child: ListTile(
          title: GestureDetector(
            onTap: () => showProfile(context, profileId: userId),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: '$ActivityItemText',
                    ),
                  ]),
            ),
          ),
          leading: CircleAvatar(
              backgroundImage:  (this.userProfileImg == null) //CachedNetworkImageProvider(userProfileImg),),
                  ? new AssetImage('images/user-avatar.png')
                  : new CachedNetworkImageProvider(this.userProfileImg)),
          subtitle: Text(
            timeago.format(timestamp.toDate()),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: mediaPreview,
        ),
      ),
    );
  }
}

showProfile(BuildContext context, {String profileId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Profile(
        profileId: profileId,
      ),
    ),
  );
}
*/