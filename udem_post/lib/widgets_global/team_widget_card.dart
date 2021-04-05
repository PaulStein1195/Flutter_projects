import 'package:flutter/material.dart';

class Team_Card extends StatelessWidget {
  final String title;
  final String hint;
  final String teamValidator;
  final String goalValidator;
  final TextEditingController controller;

  Team_Card({this.title, this.hint, this.controller, this.teamValidator, this.goalValidator});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                title, //"Name your team",
                style: TextStyle(fontSize: 29.0, fontFamily: "CabinSketch"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.0, left: 25.0, top: 15.0),
              child: Container(
                color: Colors.grey.shade50,
                child: Form(
                  child: TextFormField(
                    validator: (val) {
                      if (val.trim().length <=1 || val.isEmpty) {
                        return "Write a proper team name";
                      } else if (val.trim().length > 30) {
                        return "Team name is too long";
                      } else {
                        return null;
                      }
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: hint,
                      labelStyle:
                          TextStyle(fontSize: 15.0, fontFamily: "Roboto-Light"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
