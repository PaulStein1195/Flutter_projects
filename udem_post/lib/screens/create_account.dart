import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:udem_post/constants.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Welcome $username!"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Center(
                child: Text(
                  "Your username",
                  style: TextStyle(fontSize: 40.0, fontFamily: "CabinSketch"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (val) {
                      if (val.trim().length < 3 || val.isEmpty) {
                        return "Username too short";
                      } else if (val.trim().length > 12) {
                        return "Username too long";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => username = val,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                      labelStyle:
                      TextStyle(fontSize: 15.0, fontFamily: "Roboto-Light"),
                      hintText: "Must be at least 3 characters",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: submit,
                child: Container(
                    height: 50.0,
                    width: 115.0,
                    decoration: BoxDecoration(
                      color: kButtons,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto-Light"),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}