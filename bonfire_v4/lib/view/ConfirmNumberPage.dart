
import 'package:fire_camp/controllers/otpController.dart';
import 'package:fire_camp/controllers/themeController.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';

class ConfirmNumberPage extends StatefulWidget {
  const ConfirmNumberPage({Key? key}) : super(key: key);

  @override
  _ConfirmNumberPageState createState() => _ConfirmNumberPageState();
}

class _ConfirmNumberPageState extends State<ConfirmNumberPage> {
  final ThemeController themeCont=Get.put(ThemeController());
  final  TextEditingController _numberTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final OTPController otpController=Get.put(OTPController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:themeCont.theme.value=="dark"?Get.theme.cardColor:Get.theme.focusColor,
      body: Obx((){
          return LoadingOverlay(
            opacity: 0,
            isLoading: otpController.isLoading.value,
            progressIndicator: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: new AlwaysStoppedAnimation<Color>(themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor)
            ),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.42),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textField("Enter Number(0**********)",_numberTextEditController),
                          SizedBox(height: 40,),
                          button(0,"Send code"),
                          SizedBox(height: 40,),
                          button(1,"Logout"),
                        ],
                      ),
                    ),),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  Widget button(int index,String text) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
                fontSize: 20)),
        onPressed: () async {
          if(index==0)
            {
              validate();
            }
          if(index==1)
            {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor)),
        color: themeCont.theme.value=="dark"?Get.theme.cardColor:Get.theme.focusColor,
        textColor: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
      ),
    );
  }


  validate(){
    if (_formKey.currentState!.validate()) {
      print(_numberTextEditController.text.toString());
      //here remove 0 from user number and then concatinate country code
      otpController.sendOTp(
          '+1${_numberTextEditController.text.substring(1, _numberTextEditController.text.length)}'
      );
    }
  }

  Widget textField(String hint,TextEditingController numberTextEditController){
    return  TextFormField(
        validator: MultiValidator(
            [
              RequiredValidator(errorText: "Please Enter the Number!"),
              MinLengthValidator(9,errorText: "Please Enter a Valid Number\n(Length of Phone Number is short)!"),
             //here we define number pattern
              PatternValidator(r'^0([0-9]*)$', errorText: 'Please Enter a Valid Number\n(*0XXXXXXXXXXX)'),
            ]
        ),
        keyboardType:TextInputType.number,
        controller: _numberTextEditController,
        style: TextStyle(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor, fontSize: 20),
        cursorColor: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
        decoration: InputDecoration(
            focusColor: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
            fillColor: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: OutlineInputBorder(
              borderSide:  BorderSide(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder:OutlineInputBorder(
              borderSide:  BorderSide(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
            )
        ));
  }
}
