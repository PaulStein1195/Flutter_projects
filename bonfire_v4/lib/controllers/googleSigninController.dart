import 'package:fire_camp/view/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebaseController.dart';
class GoogleSigninController extends GetxController {
  var isLoading = false.obs;
  final _googleSignIn = GoogleSignIn();
  late User googleUser;

  Future googleLogin()async{
    //make loading true as this loader calls on loginpage
    isLoading(true).obs;
    try{
      await _googleSignIn.signOut();
      final googleUser=await _googleSignIn.signIn();
      if(googleUser==null)
      {
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
      }
      else{
        final googleAuth=await googleUser.authentication;
        final credential=GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var _user=await FirebaseAuth.instance.signInWithCredential(credential);
        if(!_user.isNull)
        {
          FirebaseController firebaseController=Get.put(FirebaseController());
          isLoading(false).obs;
          //if everything works fine store data to firebase(lib>controllers>firebaseController)
          firebaseController.storeData(_user.user!);
        }
        else{
          isLoading(false).obs;
          Get.snackbar(
            "Error",
            "Something went wrong, try again...",
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Get.theme.primaryColor,
            colorText: Colors.white,
          );
        }
      }

    }
    catch(err)
    {
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
    }
  }




  Future logout() async{
    await _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginPage());
  }

}
