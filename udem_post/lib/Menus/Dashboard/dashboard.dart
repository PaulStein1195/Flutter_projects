import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:udem_post/Menus/Notifications/notifications.dart';
import 'package:udem_post/Menus/Profile/profile.dart';
import 'package:udem_post/constants.dart';
import 'package:udem_post/models/team.dart';
import 'package:udem_post/models/team_notifier.dart';
import 'package:udem_post/screens/Create_team/create_team.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/screens/post_screen.dart';
import 'package:udem_post/widgets_global/data_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udem_post/widgets_global/post_team_card.dart';
import 'package:udem_post/widgets_global/progress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


int notifications_count = 0;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Team> teams = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDashboardTeams();
    getActivityFeed();
  }

  getDashboardTeams() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await teamsRef
        .document(currentUser.id)
        .collection("usersTeam")
        .orderBy("timestamp", descending: true)
        .getDocuments();
    setState(() {
      isLoading = false;
      teams = snapshot.documents.map((doc) => Team.fromDocument(doc)).toList();
    });
  }

  buildUserTeams() {
    if (isLoading) {
      return SpinKitFoldingCube(
        color: Colors.amber,
        size: 40.0,
      );
    } else if (teams.isEmpty) {
      return Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 50),
          Text(
            "Start creating your teams!",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w600,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 35),
          MaterialButton(
            shape: CircleBorder(),
            color: Colors.grey.shade50,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTeam(
                  currentUser: currentUser,
                ),
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.people,
                  size: 30,
                  color: Theme.of(context).accentColor,
                )),
          ),
        ],
      ));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: teams,
        ),
      );
    }
  }

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
      notifications_count++;
    });

    return notifItems;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text("Dashboard"),
            bottom: TabBar(
              indicatorColor: Theme.of(context).accentColor,
              indicatorWeight: 4.0,
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Tool Box",
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 17)),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Notifications",
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 17)),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [buildUserTeams()],
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade50,
                child: FutureBuilder(
                    future: getActivityFeed(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SpinKitFoldingCube(
                          color: Colors.amber,
                          size: 40.0,
                        );
                      }
                      return ListView(
                        children: snapshot.data,
                      );
                    }),
              ),
            ],
          )),
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
        )),
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
              backgroundImage: (this.userProfileImg ==
                      null) //CachedNetworkImageProvider(userProfileImg),),
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
