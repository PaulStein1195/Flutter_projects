import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/screens/Profile/others_profile.dart';
import 'package:bonfire_newbonfire/screens/Profile/profile.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../my_flutter_app_icons.dart';
import 'comment.dart';

User currentUser;
AuthProvider _auth;
bool isImage = false;

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String image;
  final String title;
  final String description;
  final String category;
  final String bonfire;
  final String mediaUrl;
  final Timestamp timestamp;
  final dynamic likes;
  final dynamic dislikes;
  final dynamic upgrades;

  Post({
    this.postId,
    this.ownerId,
    this.image,
    this.title,
    this.description,
    this.category,
    this.bonfire,
    this.mediaUrl,
    this.timestamp,
    this.likes,
    this.dislikes,
    this.upgrades,
  });

  factory Post.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;

    return Post(
      postId: _data['postId'],
      ownerId: _data['ownerId'],
      image: _data['image'],
      title: _data['title'],
      description: _data['description'],
      category: _data['category'],
      bonfire: _data['bonfire'],
      mediaUrl: _data["mediaUrl"],
      timestamp: _data['timestamp'],
      likes: _data['likes'],
      dislikes: _data['dislikes'],
      upgrades: _data['upgrades'],
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

  double getUpgradesCount(upgrades) {
    //if no likes, return 0
    if (upgrades == null) {
      return 0;
    }
    double count = 0;
    //if the key is explicitly set to true, add a like
    upgrades.values.forEach((val) {
      if (val == true) {
        count += 1;
        dislikes == 0;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(
        postId: this.postId,
        ownerId: this.ownerId,
        image: this.image,
        title: this.title,
        description: this.description,
        category: this.category,
        bonfire: this.bonfire,
        mediaUrl: this.mediaUrl,
        timestamp: this.timestamp,
        likes: this.likes,
        dislikes: this.dislikes,
        upgrades: this.upgrades,
        likeCount: getLikeCount(this.likes),
        dislikeCount: getDislikeCount(this.dislikes),
        upgradeCount: getUpgradesCount(this.upgrades),
      );
}

class _PostState extends State<Post> {
  AuthProvider _auth;

  final String currentUserId = currentUser?.uid;

  final String postId;
  final String ownerId;
  final String image;
  final String title;
  final String description;
  final String category;
  final String bonfire;
  final String mediaUrl;
  final Timestamp timestamp;
  bool isLiked;
  bool isDisliked;
  bool isUpgraded;
  double likeCount;
  double dislikeCount;
  double upgradeCount;
  Map likes;
  Map dislikes;
  Map upgrades;

  _PostState(
      {this.postId,
      this.ownerId,
      this.image,
      this.title,
      this.description,
      this.category,
      this.bonfire,
      this.mediaUrl,
      this.timestamp,
      this.likes,
      this.dislikes,
      this.upgrades,
      this.likeCount,
      this.dislikeCount,
      this.upgradeCount});

  handleLikePost() {
    bool _isLiked = likes[ownerId] == true;
    if (_isLiked) {
      Firestore.instance
          .collection("Posts")
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$ownerId': false});
      //removeLikeFromActivityFeed();
      setState(() {
        isLiked = false;
        likeCount -= 1;
        likes[ownerId] = false;
      });
    } else if (!_isLiked) {
      Firestore.instance
          .collection("Posts")
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$ownerId': true});
      //addLikeToActivityFeed();
      setState(() {
        isLiked = true;
        likeCount += 1;
        likes[ownerId] = true;
      });
    }
  }

  handleDislikePost() {
    bool _isDisliked = dislikes[ownerId] == true;
    if (_isDisliked) {
      Firestore.instance
          .collection("Posts")
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'dislikes.$ownerId': false});
      //removeLikeFromActivityFeed();
      setState(() {
        isDisliked = false;
        dislikeCount -= 1;
        dislikes[ownerId] = false;
      });
    } else if (!_isDisliked) {
      Firestore.instance
          .collection("Posts")
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'dislikes.$ownerId': true});
      //addLikeToActivityFeed();
      setState(() {
        isDisliked = true;
        dislikeCount += 1;
        dislikes[ownerId] = true;
      });
    }
  }

  handleUpgradePost() {
    bool _isUpgrade = upgrades[ownerId] == true;
    if (_isUpgrade) {
      Firestore.instance
          .collection("Posts")
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'upgrades.$ownerId': false});
      //removeLikeFromActivityFeed();
      setState(() {
        isUpgraded = false;
        upgradeCount -= 1;
        upgrades[ownerId] = false;
      });
    } else if (!_isUpgrade) {
      Firestore.instance
          .collection("Posts")
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'upgrades.$ownerId': true});
      //addLikeToActivityFeed();
      setState(() {
        isUpgraded = true;
        upgradeCount += 1;
        upgrades[ownerId] = true;
      });
    }
  }

  postHeader() {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: AuthProvider.instance,
      child: _buildMainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[ownerId] == true);
    isUpgraded = (upgrades[ownerId] == true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        postHeader(),
        //buildPostFooter(),
        //  postInteraction(opinion, percentage, percent),
      ],
    );
  }

  Widget _buildMainScreen() {
    double totalLikes = likeCount;
    double totalDislikes = dislikeCount;
    double totalUpgrades = upgradeCount;
    double totalVotes = likeCount + dislikeCount;

    double votePercentage = (likeCount / 100) * 1.0;
    double votePercentageText = votePercentage * 100;
    int votePercentageTextInt = votePercentageText.toInt();

    int likesToInt = totalLikes.toInt();
    int dislikesToInt = totalDislikes.toInt();
    int upgradesToInt = totalUpgrades.toInt();

    return Builder(
      builder: (BuildContext context) {
        _auth = Provider.of<AuthProvider>(context);
        return StreamBuilder<List<Post>>(
          stream: DBService.instance.getMyPosts(ownerId),
          builder: (context, _snapshot) {
            var _data = _snapshot.data;
            print(_snapshot.data);
            if (!_snapshot.hasData) {
              return CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              );
            }
            bool isPostOwner = currentUserId == ownerId;

            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      //top: BorderSide(width: 1.5, color: Colors.grey.shade600),
                      //bottom: BorderSide(width: 1.5, color: Colors.grey.shade600),
                      ),
                  color: kMainBoxColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<User>(
                        stream: DBService.instance.getUserData(ownerId),
                        builder: (context, _snapshot) {
                          var _data = _snapshot.data;
                          print(_snapshot.data);
                          if (!_snapshot.hasData) {
                            return CircularProgressIndicator(
                              color: Colors.lightBlueAccent,
                            );
                          }
                          bool isPostOwner = _auth.user.uid == ownerId;
                          print(_auth.user.uid);

                          return ListTile(
                              leading: GestureDetector(
                                onTap: () =>
                                    showProfile(context, profileId: _data.uid),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white70, width: 2.0),
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _data.profileImage == null
                                          ? AssetImage("")
                                          : NetworkImage(_data.profileImage),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                _data.name,
                                style: TextStyle(
                                    color: Colors.grey.shade100,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0),
                              ),
                              subtitle: RichText(
                                text: new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    //new TextSpan(text: user.email, style: TextStyle(decoration: TextDecoration.underline, color: Theme.of(context).accentColor)),
                                    new TextSpan(
                                        text: /*" - " + */ timeago.format(
                                          timestamp.toDate(),
                                        ),
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70)),
                                  ],
                                ),
                              ),
                              trailing: isPostOwner
                                  ? IconButton(
                                      splashColor: Colors.white70,
                                      icon: Icon(
                                        CupertinoIcons.ellipsis,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
                                                backgroundColor:
                                                    Color(0XFF333333),
                                                /*title: Text(
                                                "You can",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                color: Theme.of(context).accentColor),
                                              ),*/
                                                children: [
                                                  SimpleDialogOption(
                                                    onPressed: () {
                                                      //TODO: get link and share
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(MyFlutterApp.share, color: Colors.white70,),
                                                        SizedBox(width: 20.0,),
                                                        Text(
                                                          "Share",
                                                          style: TextStyle(
                                                              color: Colors.white70,
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      ],
                                                    )
                                                  ),
                                                  SimpleDialogOption(
                                                    onPressed: () async {
                                                      await DBService.instance
                                                          .deletePostInDB(
                                                              _auth.user.uid,
                                                              postId);
                                                      Navigator.pop(context);
                                                    },

                                                    child: Row(
                                                      children: [
                                                        Icon(MyFlutterApp.trash, color: Colors.white70,),
                                                        SizedBox(width: 20.0,),
                                                        Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color: Colors.white70,
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      ],
                                                    )
                                                  ),
                                                  SimpleDialogOption(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      color:
                                                          Colors.grey.shade100,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                        //Display option menu of sharing or Deleting Post
                                      },
                                    )
                                  : Text(""));
                        }),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                              color: category == "Technology" ? Colors.blue: category == "Nature" ? Colors.green: category == "Health" ? Colors.amber.shade700: category == "Arts" ? Colors.red: Colors.white70,
                              border: Border.all(color: Color(0XFF333333))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 2.0,
                                  left: 12.0,
                                  right: 12.0),
                              child: Text(
                                bonfire,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade100,
                                  //    color: Colors.grey.shade100
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade100),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    buildPostFooter(),
                    SizedBox(
                      height: 8.0,
                    ),
                    mediaUrl != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(mediaUrl),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(""),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  handleLikePost();
                                },
                                child: Column(
                                  children: [
                                    /*IconButton(
                                      icon: */
                                    Icon(
                                      MyFlutterApp.thumbs_up,
                                      size: 28.0,
                                      color:
                                          isLiked ? Colors.orange : Colors.grey,
                                    ),
                                    /*onPressed: () {
                                        handleLikePost();
                                      },
                                    ),*/
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "$likesToInt",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: isLiked
                                            ? Colors.orange
                                            : Colors.grey.shade200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 35.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  handleDislikePost();
                                },
                                child: Column(
                                  children: [
                                    /*IconButton(
                                      icon: */
                                    Icon(
                                      MyFlutterApp.thumbs_down,
                                      size: 28.0,
                                      color: Colors.grey,
                                    ),
                                    /*onPressed: () {
                                        handleDislikePost();
                                      },
                                    ),*/
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text("$dislikesToInt",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey.shade200)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: CircularPercentIndicator(
                                    radius: 75.0,
                                    lineWidth: 6.5,
                                    animation: true,
                                    percent: votePercentage,
                                    //0.5,
                                    center: new Text(
                                      "$votePercentageTextInt %",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.5), //"50 %",
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.orange,
                                    backgroundColor: Colors.grey.shade100),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _goMsgPage(context,
                                      postId: postId,
                                      ownerId: ownerId,
                                      image: image);
                                },
                                child: Column(
                                  children: [
                                    /*IconButton(
                                      icon: */
                                    Icon(
                                      MyFlutterApp.lnr_bubble,
                                      size: 28.0,
                                      color: Colors.grey,
                                    ),
                                    /*onPressed: () {
                                        _goMsgPage(context,
                                            postId: postId,
                                            ownerId: ownerId,
                                            image: image);
                                      },
                                    ),*/
                                    SizedBox(height: 5.0),
                                    StreamBuilder<List<Comment>>(
                                      stream: DBService.instance
                                          .getComments(postId),
                                      builder: (context, _snapshot) {
                                        var _data = _snapshot.data;
                                        if (!_snapshot.hasData) {
                                          return CircularProgressIndicator(
                                            color: Colors.lightBlueAccent,
                                          );
                                        }
                                        return Text(
                                          _data.length.toString(),
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.grey.shade200),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 35.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Tapped");
                                  handleUpgradePost();
                                },
                                child: Column(
                                  children: [
                                    /*IconButton(
                                      icon: */
                                    Icon(
                                      MyFlutterApp.campfire,
                                      size: 28.0,
                                      color: isUpgraded
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                    /*onPressed: () {
                                        print("Tapped");
                                        handleUpgradePost();
                                      },
                                    ),*/
                                    SizedBox(height: 5.0),
                                    Text("$upgradesToInt",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: isUpgraded
                                              ? Colors.orange
                                              : Colors.grey.shade200,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  buildPostFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 9, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Divider(
                color: Colors.white24,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        description,
                        style: TextStyle(
                            fontSize: 18.5,
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

_goMsgPage(BuildContext context,
    {String postId, String ownerId, String image}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
      postOwnerId: ownerId,
      postMediaUrl: image,
    );
  }));
}

Widget _listTileTrailingWidgets(Timestamp _lastMessageTimestamp) {
  return Text(
    timeago.format(_lastMessageTimestamp.toDate()),
    style: TextStyle(fontSize: 13, color: Colors.white70),
  );
}

showProfile(BuildContext context, {String profileId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OthersProfile(
        profileId: profileId,
      ),
    ),
  );
}
