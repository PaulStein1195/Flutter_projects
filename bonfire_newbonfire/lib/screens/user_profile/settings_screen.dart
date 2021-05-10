import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

AuthProvider _auth;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 39, 40, 180.0),
      appBar: kAppbar(context),
      body: ChangeNotifierProvider<AuthProvider>.value(

        value: AuthProvider.instance,
        child: Builder(
          builder: (BuildContext context) {
            var _auth = Provider.of<AuthProvider>(context);
            return StreamBuilder<User>(
              stream: DBService.instance.getUserData(_auth.user.uid),
              builder: (context, snapshot) {
                var _userData = snapshot.data;
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: SpinKitFadingFour(
                        size: 50.0,
                        color: kAmberColor,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Material(
                            color: Color(0XFFffb21a),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: MaterialButton(
                              elevation: 5.0,
                              onPressed: () {
                                _auth.logoutUser(() {});
                              },
                              child: Text(
                                "LOG OUT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
