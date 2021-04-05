import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udem_post/Menus/Agora/post_it.dart';
import 'package:udem_post/constants.dart';
import 'package:udem_post/models/post.dart';
import 'package:udem_post/models/team.dart';
import 'package:udem_post/models/user.dart';
import 'package:udem_post/screens/Create_team/create_team.dart';
import 'package:udem_post/screens/Create_team/search_users.dart';
import 'package:udem_post/screens/create_post_it.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/widgets_global/header.dart';
import 'package:udem_post/widgets_global/post_team_card.dart';
import 'package:udem_post/widgets_global/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Agora extends StatefulWidget {
  final User currentUser;

  Agora({this.currentUser});

  @override
  _AgoraState createState() => _AgoraState();
}

class _AgoraState extends State<Agora> {
  List<Post> posts;
  List<Team> teams = [];
  bool isLoading = false;
  List<String> followingList = [];

  @override
  void initState() {
    super.initState();
    getDashboardTeams();
    getTimeline();
    getFollowing();
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
    List<Team> teams =
        snapshot.documents.map((doc) => Team.fromDocument(doc)).toList();
    setState(() {
      this.teams = teams;
    });
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .document(widget.currentUser.id)
        .collection("timelinePosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();
    setState(() {
      posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(currentUser.id)
        .collection("userFollowing")
        .getDocuments();
    setState(() {
      followingList = snapshot.documents.map((doc) => doc.documentID).toList();
    });
  }

  buildUserTeams() {
    if (isLoading) {
      return SpinKitFoldingCube(
        color: Colors.amber,
        size: 50.0,
      );
    } else if (teams.isEmpty) {
      return Container(
        height: 600,
        width: 600,
        color: Colors.yellow.shade100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Card(
                elevation: 1.0,
                child: new Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.yellow.shade300,
                      Colors.yellow.shade400,
                      Colors.yellow.shade600
                    ], begin: Alignment.topCenter, end: Alignment.bottomLeft),
                  ),
                  height: 245,
                  width: 320,
                  padding: new EdgeInsets.all(15.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "There is no team created",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Questrial-Regular"),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "START TEAM!",
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                            fontFamily: "Questrial-Regular"),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      new MaterialButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTeam(),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(11.0),
                          child: Icon(
                            CupertinoIcons.group_solid,
                            size: 42.0,
                            color: Colors.white,
                          ),
                        ),
                        color: kButtons,
                        shape: CircleBorder(),
                        elevation: 6.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: teams,
        ),
      );
    }
  }

  Future getTeams() async {
    QuerySnapshot qn = await teamsRef
        .document(currentUser.id)
        .collection("usersTeam")
        .orderBy("timestamp", descending: true)
        .getDocuments();
    return qn.documents;
  }

  buildTimeline() {
    if (posts == null) {
      return SpinKitFoldingCube(
        color: Colors.amber,
        size: 50.0,
      );
    } else if (posts.isEmpty && teams.isEmpty) {
      return buildUsersToFollow();
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: teams.isEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "No Teams",
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                        RaisedButton(
                            color: Theme.of(context).accentColor,
                            child: Text("Create team"),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreateTeam())))
                      ],
                    )
                  : Text(
                      "Teams",
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
            ),
            FutureBuilder(
              future: getTeams(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitFoldingCube(
                    color: Colors.amber,
                    size: 50.0,
                  );
                } else {
                  return SizedBox(
                    height: 150.0,
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: teams.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildTeamCard(context, index)),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text(
                "Posts",
                style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Column(
              children: posts,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Center(
                child: Text(
                  "Trends",
                  style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade300,
                      fontFamily: "Questrial-Regular"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 150.0,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: Center(
                      child: Text(
                        'Some news of what has happened \n TOP 5 POSTS \n LOCAL NEWS',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "Questrial-Regular"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildTeamCard(BuildContext context, int index) {
    final team = teams[index];
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: new Container(
        width: 180.0,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.82),
            borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 8, 7, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        team.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.95),
                            fontFamily: "OpenSans"),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: Theme.of(context).backgroundColor),

              //Divider(color: Colors.grey,),
              SizedBox(height: 10.0),
              Text(
                team.goal,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).backgroundColor.withOpacity(0.82),
                    fontFamily: ""),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  buildUsersToFollow() {
    return StreamBuilder(
      stream:
          usersRef.orderBy("timestamp", descending: true).limit(30).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitFoldingCube(
            color: Colors.amber,
            size: 50.0,
          );
        }
        List<UserResult> usersResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser.id == user.id;
          final bool isFollowingUser = followingList.contains(user.id);
          //remove auth user from the list
          if (isAuthUser) {
            return;
          } else if (isFollowingUser) {
            return;
          } else {
            UserResult userResult = UserResult(user);
            usersResults.add(userResult);
          }
        });
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              usersResults.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Text(
                              "No activities! Ask friends to download the App!!",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 150.0,
                          width: 200.0,
                          child: Image.asset("assets/images/ghost.png"),
                        )
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          border: Border.all(color: Colors.grey, width: 1.2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.person_add_solid,
                            size: 25.0,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Users to follow",
                            style: TextStyle(
                              color: Colors.blueGrey.shade50,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Questrial-Regular",
                            ),
                          )
                        ],
                      ),
                    ),
              Column(children: usersResults),
            ],
          ),
        );
      },
    );
  }

  buildStoryListView() {
    if (isLoading) {
      return SpinKitFoldingCube(
        color: Colors.amber,
        size: 50.0,
      );
    } else if (teams.isEmpty) {
      return Container(
        height: 600,
        width: 600,
        color: Colors.yellow.shade100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Card(
                elevation: 1.0,
                child: new Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.yellow.shade300,
                      Colors.yellow.shade400,
                      Colors.yellow.shade600
                    ], begin: Alignment.topCenter, end: Alignment.bottomLeft),
                  ),
                  height: 245,
                  width: 320,
                  padding: new EdgeInsets.all(15.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "There is no team created",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Questrial-Regular"),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "START TEAM!",
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                            fontFamily: "Questrial-Regular"),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      new MaterialButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTeam(),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(11.0),
                          child: Icon(
                            CupertinoIcons.group_solid,
                            size: 42.0,
                            color: Colors.white,
                          ),
                        ),
                        color: kButtons,
                        shape: CircleBorder(),
                        elevation: 6.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: teams,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.people_outline,
            color: Theme.of(context).backgroundColor,
          ),
          onPressed: () {},
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 28),
        ),
        title: Text(
          "UrOpinion",
          style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontFamily: "Pacifico",
              fontWeight: FontWeight.w100),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getTimeline(),
        child: buildTimeline(),
      ),
      floatingActionButton: Container(
        height: 48,
        child: FloatingActionButton(
          backgroundColor: Colors.grey.shade50,
          child: Icon(
            Icons.description,
            color: Theme.of(context).accentColor,
            size: 32.0,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostIt()));
          },
        ),
      ),
    );
  }
}
