import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:udem_post/Menus/Dashboard/dashboard.dart';
import 'package:udem_post/Menus/Notifications/notifications.dart';
import 'package:udem_post/Menus/Profile/profile.dart';
import 'package:udem_post/constants.dart';
import 'package:udem_post/models/user.dart';
import 'package:udem_post/screens/comments.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/widgets_global//custom_image.dart';
import 'package:udem_post/widgets_global//progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//////////////////             NEED TO DESERIALIZE THE DATA FROM "USERS POST" CREATED IN FIREBASE

enum Voting { supportLine, unsupportLine }

class Post extends StatefulWidget {
  final String category;
  final String description;
  final String mediaUrl;
  final String ownerId;
  final String postId;
  final String solution;
  final String title;
  final String username;
  final dynamic likes;
  final dynamic dislikes;

  Post(
      {this.category,
      this.description,
      this.mediaUrl,
      this.ownerId,
      this.postId,
      this.solution,
      this.title,
      this.username,
      this.likes,
      this.dislikes});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      category: doc["category"],
      description: doc["description"],
      mediaUrl: doc["mediaUrl"],
      ownerId: doc["ownerId"],
      postId: doc["postId"],
      solution: doc["solution"],
      title: doc["title"],
      username: doc["username"],
      likes: doc["likes"],
      dislikes: doc["dislikes"],
    );
  }

  double getLikeCount(likes) {
    //if no likes, return 0
    if (likes == null) {
      return 0;
    }
    double count = 0;
    //if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
        dislikes == 0;
      }
    });
    return count;
  }

  double getDislikeCount(dislikes) {
    //if no likes, return 0
    if (dislikes == null) {
      return 0;
    }
    double count = 0;
    //if the key is explicitly set to true, add a dislike
    dislikes.values.forEach((val) {
      if (val == true) {
        count += 1;
        likes == 0;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(
        category: this.category,
        description: this.description,
        mediaUrl: this.mediaUrl,
        ownerId: this.ownerId,
        postId: this.postId,
        solution: this.solution,
        title: this.title,
        username: this.username,
        likes: this.likes,
        dislikes: this.dislikes,
        likeCount: getLikeCount(this.likes),
        dislikeCount: getDislikeCount(this.dislikes),
      );
}

class _PostState extends State<Post> {
  Voting selectedVote;
  int group = 1;

  final String currentUserId = currentUser?.id;
  final String category;
  final String description;
  final String mediaUrl;
  final String ownerId;
  final String postId;
  final String solution;
  final String title;
  final String username;
  double likeCount;
  double dislikeCount;
  Map likes;
  Map dislikes;
  bool isLiked;
  bool isDisliked;

  _PostState(
      {this.category,
      this.description,
      this.mediaUrl,
      this.ownerId,
      this.postId,
      this.solution,
      this.title,
      this.username,
      this.likes,
      this.dislikes,
      this.likeCount,
      this.dislikeCount});

  buildPostHeader() {
    return FutureBuilder(
      future: usersRef.document(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        bool isPostOwner = currentUserId == ownerId;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: GestureDetector(
                onTap: () => showProfile(context, profileId: user.id),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                ),
              ),
              title: GestureDetector(
                onTap: () => showProfile(context, profileId: user.id),
                child: Text(
                  user.username,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              subtitle: Text("Club / Team"),
              trailing: isPostOwner
                  ? IconButton(
                      onPressed: () => handleDeletePost(context),
                      icon: FaIcon(
                        FontAwesomeIcons.ellipsisV,
                        size: 17,
                        color: Colors.grey.shade700,
                      ),
                    )
                  : Text(""),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, bottom: 8.0, right: 8.0, top: 8.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: new Text(
                        title,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6.5,
            )
          ],
        );
      },
    );
  }

  handleDeletePost(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Remove this post?"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  deletePost();
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  //Note: To delete a Post the ownerId and current userId must be the same

  deletePost() async {
    postsRef
        .document(ownerId)
        .collection("userPosts")
        .document(postId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    //delete image from the post
    storageRef.child("post_$postId.jpg").delete();
    //Then delete all activity feed notifications
    QuerySnapshot activityFeedSnapshot = await activityFeedRef
        .document(ownerId)
        .collection("feedItems")
        .where("postId", isEqualTo: postId)
        .getDocuments();
    activityFeedSnapshot.documents.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //Then delete all comments
    QuerySnapshot commentsSnapshot = await commentsRef
        .document(postId)
        .collection("comments")
        .getDocuments();
    commentsSnapshot.documents.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;
    if (_isLiked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$currentUserId': false});
      //removeLikeFromActivityFeed();
      setState(() {
        isLiked = false;
        likeCount -= 1;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$currentUserId': true});
      //addLikeToActivityFeed();
      setState(() {
        isLiked = true;
        likeCount += 1;
        likes[currentUserId] = true;
      });
    }
  }

  handleUnLikePost() {
    bool _isDisliked = dislikes[currentUserId] == true;
    if (_isDisliked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'dislikes.$currentUserId': false});
      //removeLikeFromActivityFeed();
      setState(() {
        isDisliked = false;
        dislikeCount -= 1;
        dislikes[currentUserId] = false;
      });
    } else if (!_isDisliked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'dislikes.$currentUserId': true});
      //addLikeToActivityFeed();
      setState(() {
        isDisliked = true;
        dislikeCount += 1;
        dislikes[currentUserId] = true;
      });
    }
  }

  buildPostImage() {
    double totalVotes = likeCount + dislikeCount;
    double votePercentage = (likeCount / 5) * 1.0;
    int average = 12;

    int convertToIntVotes = totalVotes.toInt();
    double votePercentageText = votePercentage * 100;
    int votePercentageTextInt = votePercentageText.toInt();
    return FutureBuilder(
      future: usersRef.document(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        bool isPostOwner = currentUserId == ownerId;
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 420,
                  width: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: NetworkImage(mediaUrl),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 50,
                        blurRadius: 20,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                showProfile(context, profileId: user.id),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(user.photoUrl),
                                ),
                                border: Border.all(
                                    color: Theme.of(context).buttonColor,
                                    width: 2.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      showProfile(context, profileId: user.id),
                                  child: Text(
                                    user.username,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).backgroundColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "TEAM/CLUB/ 3 hours ago",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isPostOwner
                          ? IconButton(
                              onPressed: () => handleDeletePost(context),
                              icon: FaIcon(
                                FontAwesomeIcons.ellipsisV,
                                size: 17,
                                color: Colors.grey.shade50,
                              ),
                            )
                          : Text(""),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 260, 9, 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          title,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 5,
              left: MediaQuery.of(context).size.width * 0.050,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => showComments(
                            context,
                            postId: postId,
                            ownerId: ownerId,
                            mediaUrl: mediaUrl,
                          ),
                          icon: Icon(Icons.forum,
                              color: Theme.of(context).buttonColor),
                        ),
                        Text(" 123"),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: new CircularPercentIndicator(
                              radius: 48.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: votePercentage,
                              center: new Text(
                                "$votePercentageTextInt%",
                                style: new TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.2,
                                    fontFamily: "Questrial-Regular",
                                    color: Theme.of(context).buttonColor),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Theme.of(context).buttonColor,
                              backgroundColor: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        handleLikePost();
                      },
                      icon: isLiked
                          ? Icon(
                              CupertinoIcons.check_mark_circled,
                              color: Colors.blueGrey,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.8),
                            ),
                      iconSize: 40.0,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, bottom: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Votes: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 1.0, bottom: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$convertToIntVotes",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildPostFooter() {
    double totalVotes = likeCount + dislikeCount;
    double votePercentage = (likeCount / 10) * 1.0;
    int average = 12;

    int convertToIntVotes = totalVotes.toInt();
    double votePercentageText = votePercentage * 100;
    int votePercentageTextInt = votePercentageText.toInt();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 9, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "DESCRIPTION",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            description,
                            style: TextStyle(
                                fontSize: 15.5,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "SOLUTION",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            solution,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: new CircularPercentIndicator(
                          radius: 92.0,
                          lineWidth: 10.0,
                          animation: true,
                          percent: votePercentage,
                          center: new Text(
                            "$votePercentageTextInt%",
                            style: new TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.5,
                                fontFamily: "Questrial-Regular",
                                color: Theme.of(context).buttonColor),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Theme.of(context).buttonColor,
                          backgroundColor: Colors.grey.shade50),
                    ),
                    IconButton(
                      onPressed: () {
                        handleLikePost();
                      },
                      icon: isLiked
                          ? Icon(
                              CupertinoIcons.check_mark_circled,
                              color: Colors.blueGrey,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color:
                                  Theme.of(context).buttonColor.withOpacity(0.8),
                            ),
                      iconSize: 45.0,
                    ),
                    /*IconButton(
                      onPressed: () {
                        handleUnLikePost();
                      },
                      icon: isDisliked
                          ? Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: Colors.orange.shade300,
                            )
                          : Icon(
                              CupertinoIcons.clear_circled,
                              color: Colors.blueGrey,
                            ),
                      iconSize: 45.0,
                    ),*/
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Votes: " + "$convertToIntVotes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                /*Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 3.0, bottom: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Participation: ",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),*/
                GestureDetector(
                  onTap: () => showComments(
                    context,
                    postId: postId,
                    ownerId: ownerId,
                    mediaUrl: mediaUrl,
                  ),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 8.0),
                        Text(
                          "Forum",
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Icon(
                          Icons.forum,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                )*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked =
        (likes[currentUserId] == false); //Avoids the isLiked to be set as null
    isDisliked = (dislikes[currentUserId] ==
        false); //Avoids the isDisliked to be set as nulled

    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: Container(
        /*decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: LinearGradient(colors: [
            Colors.yellow.shade300,
            Colors.yellow.shade300,
            Colors.yellow.shade400
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),*/
        child: Container(
          child: Column(
            children: <Widget>[
              //buildPostHeader(),
              buildPostImage(),
              buildPostFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

showComments(BuildContext context,
    {String postId, String ownerId, String mediaUrl}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
      postOwnerId: ownerId,
      postMediaUrl: mediaUrl,
    );
  }));
}
