import 'package:bomfire_v3/controllers/firebaseController.dart';
import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:bomfire_v3/model/user.dart';
import 'package:bomfire_v3/my_flutter_app_icons.dart';
import 'package:bomfire_v3/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Access/loginPage.dart';

class BonfiresScreen extends StatefulWidget {
  const BonfiresScreen({Key? key}) : super(key: key);

  @override
  _BonfiresScreenState createState() => _BonfiresScreenState();
}

class _BonfiresScreenState extends State<BonfiresScreen> {
  final FirebaseController firebaseController = Get.put(FirebaseController());

  //get the userID from back, as if we get here it causes error
  String userID = Get.arguments;
  final ThemeController themeCont = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeCont.theme.value == "dark"
          ? Get.theme.primaryColorDark
          : Get.theme.primaryColorLight,
      body: StreamBuilder<User>(
        stream: DBService.instance.getUserData(userID),
        builder: (_context, _snapshot) {
          var _userData = _snapshot.data;
          print(_userData);
          if (!_snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "edit_profile"),
                  child: Card(
                    color: Color.fromRGBO(41, 39, 40, 150.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white70, width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                    image: DecorationImage(
                                        image: NetworkImage(_userData!.profileImage))),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userData.name,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0),
                                ),
                                Text(
                                  _userData.email,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 17.0,
                                      letterSpacing: 0.25),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Icon(
                              MyFlutterApp.pencil,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bio",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                _userData
                                    .bio,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white70),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 2.5),
                    child: Row(
                      children: [
                        Icon(
                          MyFlutterApp.pie_chart,
                          size: 25.0,
                          color: Colors.grey.shade100,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "Games",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 2.5),
                    child: Row(
                      children: [
                        Icon(
                          MyFlutterApp.lightbulb,
                          size: 25.0,
                          color: Colors.grey.shade100,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "Tools",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white70,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                logoutBtn("LOGOUT")
              ],
            );
          }
        },
      ),
    );
  }

  dataNotExist() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Get.snackbar(
        "Error",
        "Something went wrong, Please login again",
        icon: Icon(
          Icons.error_outline,
          color: themeCont.theme.value == "dark"
              ? Get.theme.focusColor
              : Get.theme.cardColor,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.accentColor,
        colorText: themeCont.theme.value == "dark"
            ? Get.theme.focusColor
            : Get.theme.cardColor,
        snackbarStatus: (status) async {
          if (status == SnackbarStatus.CLOSED) {
            //didn't clear all prefs, as theme will set to default dark mode,
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("id");
            prefs.remove("loggedIn");
            prefs.remove("name");
            prefs.remove("email");
            prefs.remove("photo");
            prefs.remove("number");
            print("logout");
            Get.offAll(LoginPage());
          }
        },
      );
      // executes after build
    });
  }

  Widget _userProfileData(
      String _name, String _email, String _image, String _bio) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "edit_profile"),
      child: Card(
        color: Color.fromRGBO(41, 39, 40, 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(image: NetworkImage(_image))),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0),
                    ),
                    Text(
                      _email,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17.0,
                          letterSpacing: 0.25),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30.0,
                ),
                Icon(
                  MyFlutterApp.pencil,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bio",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    _bio,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white70, fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  logoutBtn(String text) {
    return InkWell(
      onTap: () async {
        //didn't clear all prefs, as theme will set to default dark mode,
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("id");
        prefs.remove("loggedIn");
        prefs.remove("name");
        prefs.remove("email");
        prefs.remove("photo");
        prefs.remove("number");
        print("logout");
        Get.offAll(LoginPage());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        decoration: BoxDecoration(
          color: Get.theme.accentColor,
          borderRadius: new BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              color: themeCont.theme.value == "dark"
                  ? Get.theme.primaryColorLight
                  : Get.theme.primaryColorDark,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                  color: themeCont.theme.value == "dark"
                      ? Get.theme.primaryColorLight
                      : Get.theme.primaryColorDark,
                  fontSize: 20.0),
            ),
            //IconButton(icon: FaIcon(FontAwesomeIcons.forward, color: themeCont.theme=="dark"?Get.theme.cardColor:themeCont.theme=="dark"?Get.theme.focusColor:Get.theme.cardColor,),onPressed: (){},) ,
          ],
        ),
      ),
    );
  }
}
