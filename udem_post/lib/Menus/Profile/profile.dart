import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udem_post/constants.dart';
import 'package:udem_post/screens/create_post_it.dart';
import 'package:udem_post/screens/edit_profile.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/widgets_global//custom_image.dart';
import 'package:udem_post/models/post.dart';
import 'package:udem_post/widgets_global//header.dart';
import 'package:udem_post/widgets_global//post_tile.dart';
import 'package:udem_post/widgets_global//progress.dart';
import 'package:udem_post/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udem_post/screens/Create_team/create_team.dart';
import 'package:udem_post/widgets_global/post_team_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Profile extends StatefulWidget {
  final String profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.id;
  String postOrientation = "grid";
  bool isLoading = false;
  bool isFollowing = false;
  int postCount = 0;
  int followingCount = 0;
  int followerCount = 0;
  int teamCount = 0;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getProfilePosts();
    checkIfFollowing();
    getFollowers();
    getFollowing();
    getTeam();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .getDocuments();
    setState(() {
      followerCount = snapshot.documents.length;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(widget.profileId)
        .collection("userFollowing")
        .getDocuments();
    setState(() {
      followingCount = snapshot.documents.length;
    });
  }

  getTeam() async {
    QuerySnapshot snapshot = await teamsRef
        .document(widget.profileId)
        .collection("usersTeam")
        .getDocuments();
    setState(() {
      teamCount = snapshot.documents.length;
    });
  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .document(widget.profileId)
        .collection("userPosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();
    setState(() {
      isLoading = false;
      postCount = snapshot.documents.length;
      posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  buildProfileHeader() {
    return Container(
      color: Colors.grey.shade50,
      child: FutureBuilder(
          future: usersRef.document(widget.profileId).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SpinKitFoldingCube(
                color: Colors.amber,
                size: 40.0,
              );
            }
            User user = User.fromDocument(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              CachedNetworkImageProvider(user.photoUrl),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 20, 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      user.username,
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.5),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        user.bio,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                  editProfileButton()
                                ],
                              ),
                            ),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                editProfileButton(),
                              ],
                            )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade800),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //buildCountColumn("clubs", 0),
                        buildCountColumn("teams", teamCount),
                        buildCountColumn("posts", postCount),
                        buildCountColumn("following", followingCount),
                        buildCountColumn("followers", followerCount),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade800),
                ],
              ),
            );
          }),
    );
  }

  editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(
                  currentUserId: currentUserId,
                ))).then((value) {
      setState(() {});
    });
  }

  Container buildButton({String text, Function function}) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 160.0,
          height: 27.0,
          child: Text(
            text,
            style: TextStyle(
                color: isFollowing ? Colors.white : Colors.grey.shade50,
                fontWeight: FontWeight.w600,
                fontFamily: "Questrial-Regular"),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isFollowing ? Theme.of(context).buttonColor : kButtons,
              borderRadius: BorderRadius.circular(15.0)),
        ),
      ),
    );
  }

  editProfileButton() {
    //Viewing your own profile - should show edit profile button
    bool isProfileOwner = currentUserId == widget.profileId;
    if (isProfileOwner) {
      return buildButton(text: "Edit profile", function: editProfile);
    } else if (isFollowing) {
      return buildButton(text: "Unfollow", function: handleUnfollowUser);
    } else if (!isFollowing) {
      return buildButton(text: "Follow", function: handleFollowUser);
    }
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    //Delete info of the followers
    followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //Delete info of following users
    followingRef
        .document(currentUserId)
        .collection("userFollowing")
        .document(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // delete activity feed item for them
    activityFeedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    //Make auth user to share with ANOTHER USER their activities
    followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .document(currentUserId)
        .setData({});
    //Make YOU as USER to follow others profile
    followingRef
        .document(currentUserId)
        .collection("userFollowing")
        .document(widget.profileId)
        .setData({});
    //Update activity Feed and add it
    activityFeedRef
        .document(widget.profileId)
        .collection("feedItems")
        .document(currentUserId)
        .setData({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": currentUser.username,
      "userId": currentUserId,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": timestamp
    });
  }

  buildProfilePost() {
    if (isLoading) {
      return SpinKitFoldingCube(
        color: Colors.amber,
        size: 50.0,
      );
    } else if (posts.isEmpty) {
      return Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 50),
          Text(
            "Start creating your first post!",
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
                builder: (context) => CreatePostIt(
                  currentUser: currentUser,
                ),
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.description,
                  size: 30,
                  color: Theme.of(context).accentColor,
                )),
          ),
        ],
      ));
    } else if (postOrientation == "grid") {
      List<GridTile> gridTiles = [];
      posts.forEach((post) {
        gridTiles.add(GridTile(child: PostTile(post)));
      });
      return GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          mainAxisSpacing: 1.5,
          crossAxisSpacing: 1.5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: gridTiles);
    } else if (postOrientation == "list") {
      return Column(
        children: posts,
      );
    }
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }

  buildTogglePostOrientation() {
    return Container(
      color: Colors.grey.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () => setPostOrientation("grid"),
            icon: Icon(
              Icons.grid_on,
              color: postOrientation == "grid"
                  ? Theme.of(context).accentColor
                  : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => setPostOrientation("list"),
            icon: Icon(
              Icons.list,
              color: postOrientation == "list"
                  ? Theme.of(context).accentColor
                  : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: header(context, isAppTitle: false, titleText: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildProfileHeader(),
            buildTogglePostOrientation(),
            buildProfilePost()
          ],
        ),
      ),
    );
  }
}
