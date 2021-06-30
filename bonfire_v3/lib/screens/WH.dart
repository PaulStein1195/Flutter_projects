import 'package:bomfire_v3/controllers/firebaseController.dart';
import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:bomfire_v3/screens/Profile/profile.dart';
import 'package:bomfire_v3/widget/TabBar.dart';
import 'package:bomfire_v3/widget/floatingButton.dart';
import 'package:bomfire_v3/widget/searchbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_flutter_app_icons.dart';
import 'Access/loginPage.dart';
import 'Bonfire/bonfire_screen.dart';

class WHScreen extends StatefulWidget {
  const WHScreen({Key? key}) : super(key: key);

  @override
  _WHScreenState createState() => _WHScreenState();
}

class _WHScreenState extends State<WHScreen> {
  final FirebaseController firebaseController = Get.put(FirebaseController());
  final ThemeController themeController = Get.put(ThemeController());
  bool themeVal = true;

  //get the userID from back, as if we get here it causes error
  String userID = Get.arguments;
  final ThemeController themeCont = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kFloatingAction(context),
      backgroundColor: themeCont.theme.value == "dark"
          ? Get.theme.primaryColorDark
          : Get.theme.primaryColorLight,
      body: FutureBuilder<DocumentSnapshot>(
        future:
            Firestore.instance.collection('users').document(userID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "Something went wrong",
              style: TextStyle(
                color: themeCont.theme.value == "dark"
                    ? Get.theme.primaryColorLight
                    : Get.theme.primaryColorDark,
                fontSize: 17,
              ),
            ));
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            //as data not exist in firebase so simply move back to login page, rare case
            dataNotExist();
            return Center(
                child: Text(
              "No record found",
              style: TextStyle(
                color: themeCont.theme.value == "dark"
                    ? Get.theme.primaryColorLight
                    : Get.theme.primaryColorDark,
                fontSize: 17,
              ),
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //convert data to map, we can also show number here, as its in map
            Map<String, dynamic> data =
                snapshot.data as Map<String, dynamic>;
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                //TODO: floatingActionButton: kFloatingAction(context),
                appBar: AppBar(
                  elevation: 0.0,
                  leading: IconButton(
                    color: themeCont.theme.value == "dark"
                        ? Colors.white
                        : Colors.black,
                    onPressed: () {
                      showSearch(context: context, delegate: SearchBar());
                    },
                    icon: Icon(
                      MyFlutterApp.magnifier,
                      size: 25.0,
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      color: themeCont.theme.value == "dark"
                          ? Colors.white
                          : Colors.black,
                      splashColor: Colors.white70,
                      onPressed: () {},
                      /* => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => InboxScreen())),*/
                      icon: Icon(
                        MyFlutterApp.envelope,
                        size: 27.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                  bottom: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    indicatorColor: Colors.orange,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      TabTitle("Happening"),
                      TabTitle("Going"),
                    ],
                  ),
                  backgroundColor: themeController.theme.value == "dark"
                      ? Colors.black.withOpacity(0.9)
                      : Colors.white.withOpacity(0.9),
                ),
                body: TabBarView(
                  children: [
                    BonfiresScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: new AlwaysStoppedAnimation<Color>(
                themeCont.theme.value == "dark"
                    ? Get.theme.primaryColorLight
                    : Get.theme.primaryColorDark,
              ),
            ),
          );
        },
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

  Widget userProfileImage(String image) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.4,
      height: 140.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          )),
    );
  }

  Widget userText(String text) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: themeCont.theme.value == "dark"
                ? Get.theme.primaryColorLight
                : Get.theme.primaryColorDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
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
