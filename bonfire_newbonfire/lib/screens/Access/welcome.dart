import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/providers/googleSignIn.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:provider/provider.dart';

AuthProvider _auth;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kMainBoxColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: Builder(builder: (BuildContext context) {
            _auth = Provider.of<AuthProvider>(context);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        height: 170.0,
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo_shadow.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Join your Bonfire',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Material(
                    elevation: 1.0,
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      //color: Colors.grey,
                      onPressed: () {
                        //Go to login screen.
                        Navigator.pushNamed(context, "login");
                      },
                      minWidth: 200.0,
                      height: 50.0,
                      child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: OutlineButton(
                    splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.googleLogin();
                      DBService.instance.createUserInDB(provider.user.id, provider.user.displayName, provider.user.email, "", provider.user.photoUrl);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    highlightElevation: 0,
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image:
                                  AssetImage("assets/images/google_logo.png"),
                              height: 30.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: FlatButton(
                    onPressed: () {
                      //Go to registration screen.
                      Navigator.pushNamed(context, "register");
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
