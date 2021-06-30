
import 'package:fire_camp/controllers/firebaseController.dart';
import 'package:fire_camp/controllers/otpController.dart';
import 'package:fire_camp/controllers/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({Key? key}) : super(key: key);

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final ThemeController themeCont=Get.put(ThemeController());
  final OTPController otpController=Get.put(OTPController());
  final FirebaseController firebaseController=Get.put(FirebaseController());


  //get phone and verification id from confirmnumberpage
  var phone=Get.arguments[0];
  var verificationId=Get.arguments[1];

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  //to gives the decoration to pinput fields
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Get.theme.accentColor,width: 2),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    changeTheme();
    super.initState();
  }

  changeTheme() async {
    //call this again as when we move back from captcha page it set to default theme
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme=prefs.getString("theme")??"dark";
    if(theme=="light"){
      themeCont.ChangeTheme("light");
    }
    else{
      themeCont.ChangeTheme("dark");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:themeCont.theme.value=="dark"?Get.theme.cardColor:Get.theme.focusColor,
      body: Obx((){
          return LoadingOverlay(
            opacity: 0,
            isLoading: otpController.isLoading.value || firebaseController.isLoading.value ,
            progressIndicator: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: new AlwaysStoppedAnimation<Color>(themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor)
            ),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 170,),
                        Text("We have sent you an",
                          style: TextStyle(
                            color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("access code via SMS",
                          style: TextStyle(
                            color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 60,),
                        pinTextfield(),
                        SizedBox(height: 55,),
                        button(),
                        SizedBox(height: 30,),
                        resendText(),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  button(){
    return InkWell(
      onTap: ()
      {

        if(_pinPutController.text.length == 6 && _pinPutController.text.toString().isNotEmpty){
          otpController.verifyOTP(_pinPutController.text.toString(),verificationId,phone);
        }
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
            Text("Continue", style: TextStyle(color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,fontSize: 20.0),),
            SizedBox(width:10),
            Icon(Icons.forward, color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,),
            //IconButton(icon: FaIcon(FontAwesomeIcons.forward, color: themeCont.theme=="dark"?Get.theme.cardColor:themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,),onPressed: (){},) ,
          ],
        ),
      ),
    );
  }

  pinTextfield(){
    return PinPut(
      fieldsCount: 6,
      autofocus: false,
      controller: _pinPutController,
      submittedFieldDecoration: _pinPutDecoration.copyWith(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 2,color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor)
      ),
      textStyle: TextStyle(fontSize: 25.0, color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor),
      eachFieldMargin: EdgeInsets.all(0),
      eachFieldWidth: 40.0,
      eachFieldHeight: 50.0,
      selectedFieldDecoration: _pinPutDecoration,
      followingFieldDecoration: _pinPutDecoration.copyWith(
        border: Border.all(
          color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor.withOpacity(0.5),
          width: 2
        ),
      ),
      onSubmit: (String pin) {
        //automatically call when all the fields fill
        if(_pinPutController.text.length == 6 && _pinPutController.text.toString().isNotEmpty){
          otpController.verifyOTP(_pinPutController.text.toString(),verificationId,phone);
        }
      },
      focusNode: _pinPutFocusNode,
    );
  }


Widget resendText(){
    return InkWell(
      onTap: (){
        //to send otp again, this function is in lib>controllers>otpController
        otpController.sendOTp(phone);
      },
      child: Text("Resend code",
        style: TextStyle(
          color: themeCont.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
          fontSize: 20,
        ),
      ),
    );
}
}

