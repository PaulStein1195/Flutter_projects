import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_camp/controllers/firebaseController.dart';
import 'package:fire_camp/controllers/themeController.dart';
import 'package:fire_camp/view/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseController firebaseController = Get.put(FirebaseController());
  //get the userID from back, as if we get here it causes error
  String userID = Get.arguments;
  final ThemeController themeCont=Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeCont.theme.value=="dark"?Get.theme.cardColor:Get.theme.focusColor,
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userID)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Something went wrong",
                  style: TextStyle(
                    color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
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
                    color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
                    fontSize: 17,
                  ),
                ));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                //convert data to map, we can also show number here, as its in map
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              userProfileImage(data['photo'].toString()),
                              SizedBox(
                                height: 20,
                              ),
                              userText(data['name'].toString()),
                              SizedBox(
                                height:10,
                              ),
                              userText(data['email'].toString()),
                              SizedBox(
                                height: 30,
                              ),
                              logoutBtn("Logout")
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor)));
              ;
            }));
  }

  logoutBtn(String text){
    return InkWell(
      onTap: ()
      async {
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
            Icon(Icons.logout, color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,),
            SizedBox(width:10),
            Text(text, style: TextStyle(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,fontSize: 20.0),),
            //IconButton(icon: FaIcon(FontAwesomeIcons.forward, color: themeCont.theme=="dark"?Get.theme.cardColor:themeCont.theme=="dark"?Get.theme.focusColor:Get.theme.cardColor,),onPressed: (){},) ,
          ],
        ),
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
          color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.accentColor,
        colorText: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
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
            Get.offAll(LoginPage());          }
        },
      );
      // executes after build
    });
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
            color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
