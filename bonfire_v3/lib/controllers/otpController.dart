import 'package:bomfire_v3/controllers/firebaseController.dart';
import 'package:bomfire_v3/screens/Access/loginPage.dart';
import 'package:bomfire_v3/screens/Access/verificationCodePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OTPController extends GetxController {
  var isLoading = false.obs;
  final FirebaseController firebaseController=Get.put(FirebaseController());


  sendOTp(String phone) async {
    FirebaseAuth fAuth = FirebaseAuth.instance;
    print(phone);
    isLoading(true).obs;
    fAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 90),
        verificationFailed: (AuthException exception) {
          print(exception);
          if (exception.code == 'invalid-phone-number') {
            isLoading(false).obs;
            Get.snackbar(
              "Error",
              "Invalid Phone Number!",
              icon: Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackbarStatus: (status) {
                print(status);
                if(status==SnackbarStatus.CLOSED)
                {
                }
              },
            );
            print('The provided phone number is not valid.');
          }
          if (exception.code == 'too-many-requests') {
            isLoading(false).obs;
            Get.snackbar(
              "Error: Too Many Requests!",
              "Please try Again later, you have requested OTP too many many times.",
              icon: Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackbarStatus: (status) {
                print(status);
                if(status==SnackbarStatus.CLOSED)
                {
                }
              },
            );
            print('The provided phone number is not valid.');
          }
          print(exception);
        },
        codeSent: (String verificationId, [int? forceResendingToken])  {
           isLoading(false).obs;
           print(verificationId);
          Get.to(VerificationCodePage(),arguments: [phone, verificationId]);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
           isLoading(false).obs;
          print("timeout");
        }, verificationCompleted: (AuthCredential phoneAuthCredential) {
          // we don't need this as we move to next screen to enter the code, not on same screen,
    });
  }

  verifyOTP(String code,String verificationId,String number) async {
    isLoading(true).obs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID=await prefs.getString("id")??"";
    AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId,
        smsCode:code );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      if(value.isNull)
      {
        print("errors");
        isLoading(false).obs;
        Get.snackbar(
          "Notification",
          "Invalid OTP",
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackbarStatus: (status) {
            print(status);
            if(status==SnackbarStatus.CLOSED)
            {
            }
          },
        );
      }
      else{
        if(userID.isNotEmpty)
          {
            isLoading(false).obs;
            //update user number
            firebaseController.updateUserNumber(userID,number);
          }
        else{
          print("update1 error");
          prefs.clear();
          isLoading(false).obs;
          Get.offAll(LoginPage());
        }
      }
    }).onError((error, stackTrace) {
      print("new error");
      isLoading(false).obs;
      Get.snackbar(
        "Notification",
        "Invalid OTP",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackbarStatus: (status) {
          print(status);
          if(status==SnackbarStatus.CLOSED)
          {
          }
        },
      );

    });
  }
}
