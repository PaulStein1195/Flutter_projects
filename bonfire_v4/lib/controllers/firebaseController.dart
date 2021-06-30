import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_camp/view/ConfirmNumberPage.dart';
import 'package:fire_camp/view/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseController extends GetxController {
  var isLoading = false.obs;
  var isNewUser = false.obs;
  var isNumberExist = false.obs;
  String userNumber="";

  storeData(User user) async{
    //make loading true as this loader calls on loginpage
    isLoading(true).obs;
    //check whether user already register or not through their email
    await doesEmailAlreadyExist(user.email!);

    //if its new user then register, if not then update user details
    if(isNewUser.value)
    {
      addNewuser(user);
    }
    else{
      updateUserInfo(user);
    }
  }

  doesEmailAlreadyExist(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
    .where('email', isEqualTo: email)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if(documents.length==1)
      {
        //calls this just to make sure that data exist
        documents.forEach((doc) {
          print("user exist"+doc['email']);
          print("user exist"+doc['number']);
          if(doc['number'].toString().isNotEmpty)
            {
              userNumber=doc['number'].toString();


              isNumberExist(true).obs;
            }
        });
      }
    else{
      isNewUser(true).obs;
      print("user not exist");
    }
  }

  addNewuser(User user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set({
      "uid": user.uid,
      "name": user.displayName.toString(),
      "email": user.email.toString(),
      "number": "",
      "photo" : user.photoURL.toString()}).then((value) {
        //store user details to preferences to get user uid on splash page and pass to homepage
      storeToPref(user);
      print("inserted");
      isLoading(false).obs;
      //as its new user so move user to number taken page
      Get.offAll(ConfirmNumberPage());
    }).onError((error, stackTrace) {
      isLoading(false).obs;
      Get.snackbar(
        "Error",
        "Something Went wrong, Try Again...",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.accentColor,
        colorText: Colors.white,
      );
      print("error check insert"+error.toString());
    });
  }
  updateUserInfo(User user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .update({
      "uid": user.uid,
      "name": user.displayName.toString(),
      "email": user.email.toString(),
      "photo" : user.photoURL.toString()}).then((value) {
      print("updated");
      isLoading(false).obs;
      storeToPref(user);
      if(isNumberExist.value)
        {
          //here we check whether number is in firebase or not,if number found then goto homepage,if not then move to number page
          Get.offAll(HomePage(),arguments: user.uid);
        }
      else{
        Get.offAll(ConfirmNumberPage());
      }
    }).onError((error, stackTrace) {
      isLoading(false).obs;
      Get.snackbar(
        "Error",
        "Something Went wrong, Try Again...",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.accentColor,
        colorText: Colors.white,
      );
      print("error check update"+error.toString());
    });
  }

  updateUserNumber(String userID, String number) async {
    isLoading(true).obs;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .update({
      "number": number}).then((value) {
      print("updated");
      storeNumberToPref(number);
      isLoading(false).obs;
      Get.offAll(HomePage(),arguments: userID);
    }).onError((error, stackTrace) {
      //isLoading(false).obs;
      print("error");
      Get.snackbar(
        "Error",
        "Something Went wrong, Try Again...",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.accentColor,
        colorText: Colors.white,
      );
      print("error check update"+error.toString());
    }).whenComplete(() => print("completed"));
  }


  storeToPref(User user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("200");
    prefs.setBool("loggedIn", true);
    prefs.setString("id", user.uid.toString());
    prefs.setString("name", user.displayName.toString());
    prefs.setString("email", user.email.toString());
    prefs.setString("photo", user.photoURL.toString());
    prefs.setString("number", userNumber);

    print("userID"+prefs.getString("id").toString());

  }
  storeNumberToPref(String updatedNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("number", updatedNumber);
  }
}
