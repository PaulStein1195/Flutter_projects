import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:udem_post/Menus/Profile/profile.dart';
import 'package:udem_post/constants.dart';
import 'package:udem_post/models/user.dart';
import 'package:udem_post/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udem_post/widgets_global//progress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController displayBioController = TextEditingController();

  bool isLoading = false;
  User user;

  bool _bioValid = true;
  bool _nameValid = true;


  get currentUserId => null;

  @override
  void initState() {
    super.initState();
    getUser();
  }


  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.username;
    displayBioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }

  Column buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "Your username",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                //fontFamily: "CabinSketch",
                fontSize: 20),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Username",
            errorText: _nameValid ? null : "Displayed Username too short",
          ),
        ),
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "Your bio",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                //fontFamily: "CabinSketch",
                fontSize: 20),
          ),
        ),
        TextField(
          controller: displayBioController,
          decoration: InputDecoration(
            hintText: "Update Bio",
            errorText: _bioValid ? null : "Bio is too long",
          ),
        ),
      ],
    );
  }

  userProfileValidateData() {
    setState(() {
      displayNameController.text
          .trim()
          .length < 3 ||
          displayNameController.text.isEmpty
          ? _nameValid = false
          : _nameValid = true;
      displayBioController.text
          .trim()
          .length > 120 ||
          displayBioController.text.isEmpty
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_bioValid && _nameValid) {
      usersRef.document(widget.currentUserId).updateData({
        "username": displayNameController.text,
        "bio": displayBioController.text,
      });

      SnackBar snackBar = SnackBar(
        content: Text(
          "Profile Updated",
        ),
        backgroundColor: Colors.lightGreen,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0), // here the desired height
        child: AppBar(
          leading: Text(""),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          elevation: 2.0,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "Edit Profile",
                style: TextStyle(
                    color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => Navigator.pop(context),
              color: Colors.green,
              iconSize: 30.0,
            )
          ],
        ),
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                        backgroundColor: Colors.grey,
                        radius: 50.0,
                      ),
                    ),
                    Positioned(
                      right: -5.0,
                      bottom: -5.0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, size: 36.0,
                          color: Colors.blue.withOpacity(0.5),),
                        onPressed: (){
                          print("Change profile Image");
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[buildNameField(),SizedBox(height: 10.0,), buildBioField()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 2.0,
                    color: Theme
                        .of(context)
                        .buttonColor,
                    onPressed: userProfileValidateData,
                    child: Text(
                      "Update profile",
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FlatButton.icon(
                    onPressed: logout,
                    icon: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      color: Theme
                          .of(context)
                          .accentColor,
                      size: 29.0,
                    ),
                    label: Text(
                      "Logout",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .accentColor,
                        fontSize: 18.0,
                        fontFamily: "Questrial-Regular",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
