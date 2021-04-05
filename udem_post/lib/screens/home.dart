import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:udem_post/Menus/Agora/agora.dart';
import 'package:udem_post/Menus/Dashboard/dashboard.dart';
import 'package:udem_post/Menus/Notifications/notifications.dart';
import 'package:udem_post/Menus/Agora/post_it.dart';
import 'package:udem_post/Menus/Profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udem_post/models/team.dart';
import 'package:udem_post/models/user.dart';
import 'create_account.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'create_account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = Firestore.instance.collection("users");
final postsRef = Firestore.instance.collection("posts");
final commentsRef = Firestore.instance.collection("comments");
final activityFeedRef = Firestore.instance.collection("feedItems");
final teamsRef = Firestore.instance.collection("teams");
final followersRef = Firestore.instance.collection("followers");
final followingRef = Firestore.instance.collection("following");
final timelineRef = Firestore.instance.collection("timeline");
final DateTime timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  double _deviceHeight;
  double _deviceWidth;

  //################## GOOGLE SIGN IN METHODS ##################
  @override
  void initState() {
    pageController = PageController();
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      // Listens when user enters account and if this has it or not
      handleSigIn(account);
    }, onError: (err) {
      print("Error signing in: $err");
    });

    //############## REAUTHENTICATE USER WHE APP IS OPENED ###############
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSigIn(account);
    }).catchError((err) {
      print("Error signing in: $err");
    });
  }

  //############## METHOD FOR both SIGN IN and SIGN IN SILENTLY ######
  handleSigIn(GoogleSignInAccount account) async {
    if (account != null) {
      await createUserInFirestore();
      setState(() {
        isAuth = true; //If has account is authorize to "buildAuthScreen()"
      });
    } else {
      setState(() {
        isAuth =
            false; //If doesn't have account is authorize to "buildUnAuthScreen()"
      });
    }
  }

  createUserInFirestore() async {
    // 1) Check if user exist in users collection in database according to their Id
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();
    // 2) If user doesn't exist send it to create account page
    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      // 3) get username from create account, use it to make  new user document in users collection
      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
        "joinedGroups": "",
      });

      //make new user their own follower (to include their post in the timeline)
      await followersRef
        .document(user.id)
      .collection("userFollowers")
      .document(user.id)
      .setData({});

      doc = await usersRef.document(user.id).get();
    }
    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    this.pageIndex = pageIndex;
  }

  changePage(int pageIndex) {
    setState(() {
      pageController.jumpToPage(
        pageIndex,
      );
    });
  }

  reset_notif_count() {
    if (pageIndex == 2 && notifications_count > 0) {
      notifications_count = 0;
    }
  }

  //################## AUTHENTICATION SCREENS ###################

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Agora(currentUser: currentUser),
          Dashboard(),
          //Notifications(),
          Profile(profileId: currentUser?.id),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: SizedBox(
        height: 55.0,
        child: BottomNavigationBar(
            backgroundColor: Colors.grey.shade50,
            currentIndex: pageIndex,
            onTap: changePage,
            type: BottomNavigationBarType.fixed,
            fixedColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey.shade400,
            items: [
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.home, size: 25),
                  title: Text(
                    "Home",
                    style: TextStyle(fontSize: 9.5, color: Theme.of(context).primaryColor),
                  )),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.newspaper, size: 25),
                  title: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 10.0, color: Theme.of(context).primaryColor),
                  )),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user, size: 25),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 9.5, color: Theme.of(context).primaryColor),
                ),
              ),
            ]),
      ),
    );
  }

  Widget buildUnAuthScreen() {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover)),
          height: _deviceHeight ,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
          alignment: Alignment.center,
          child: Container(
            height: _deviceHeight * 0.50 ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: _deviceHeight * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "UrOpinion",
                        style: TextStyle(fontSize: 60, fontFamily: "Pacifico", color: Theme.of(context).primaryColor, shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 5.0),
                            blurRadius: 5.0,
                            color: Colors.grey,
                          ),
                        ],),
                      ),
                      Text(
                        "Welcome back!",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: _deviceHeight * 0.085,
                  width: _deviceWidth,
                  child: OutlineButton(
                    splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      login();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Theme.of(context).buttonColor.withOpacity(0.8)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/images/google_logo.png"),
                              height: 55.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).buttonColor.withOpacity(0.8),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
