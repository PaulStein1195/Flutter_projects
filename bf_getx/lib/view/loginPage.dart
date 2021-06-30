
import 'package:bf_getx/controllers/firebaseController.dart';
import 'package:bf_getx/controllers/googleSigninController.dart';
import 'package:bf_getx/controllers/themeController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSigninController googleSigninController=Get.put(GoogleSigninController());
  final FirebaseController firebaseController=Get.put(FirebaseController());
  final ThemeController themeController=Get.put(ThemeController());
  bool themeVal=true;

  @override
  void initState() {
    // TODO: implement initState
    checkTheme();
    super.initState();
  }
  checkTheme() async {
    //again checktheme to apply to theme value
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme=prefs.getString("theme")??"dark";
    print(theme);
    setState(() {
      theme=="light"?themeVal=false:themeVal=true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:themeController.theme.value=="dark"?Get.theme.cardColor:Get.theme.focusColor,
        body: Obx((){
            return LoadingOverlay(
              opacity: 0,
              isLoading: googleSigninController.isLoading.value || firebaseController.isLoading.value ,
              progressIndicator: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: new AlwaysStoppedAnimation<Color>(themeController.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor)
              ),
              child: SafeArea(
                child: Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.42),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              button(0, "Continue with Google"),
                              SizedBox(height: 20,),
                              button(1, "Continue with Apple"),
                              SizedBox(height: 40,),
                              themeType()
                            ],
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
    );
  }

  button(int index, String title){
    return InkWell(
      onTap: ()
      {
        if(index==0)
          {
            //this function is in lib>controllers>googleSigninController
          googleSigninController.googleLogin();
          }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          border: Border.all(
            color: themeController.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(index==0?FontAwesomeIcons.google:FontAwesomeIcons.apple, color: themeController.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor),
            SizedBox(width:10),
            Text(title, style: TextStyle(color: themeController.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,fontSize: 18.0),),
          ],
        ),
      ),
    );
  }


  Widget themeType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(themeVal?"Dark":"Light", style: TextStyle(color: themeController.theme.value=="dark"?Get.theme.focusColor:Get.theme.cardColor,fontSize: 18.0,fontWeight: FontWeight.bold),),
        Container(
          height: 20,
          alignment: Alignment.topRight,
          child: Switch(
            value: themeVal,
            activeTrackColor: Get.theme.primaryColor,
            inactiveTrackColor: Get.theme.primaryColor,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            onChanged: (value) {
              setState(() {
                themeVal = value;
                if(themeVal)
                  {
                    themeController.ChangeTheme("dark");
                  }
                else{
                  themeController.ChangeTheme("light");
                }
              });
            },
          ),
        ),
      ],
    );
  }

}
