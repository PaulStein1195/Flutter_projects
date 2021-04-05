import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:udem_post/Menus/Agora/agora.dart';
import 'package:udem_post/Menus/Agora/post_it.dart';
import 'package:udem_post/Menus/Dashboard/dashboard.dart';
import 'package:udem_post/screens/Create_team/search_users.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/models/user.dart';
import 'package:uuid/uuid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTeam extends StatefulWidget {
  final User currentUser;
  final String profileId;

  CreateTeam({this.currentUser, this.profileId});

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final _formKey = GlobalKey<FormState>();
  String teamId = Uuid().v4();
  bool isSubmitted = false;
  TextEditingController teamNameController = TextEditingController();
  TextEditingController teamGoalController = TextEditingController();

  //String teamId = Uuid().v4(); //Assigns and specific Uuid to the team Stored

  ////**********************IMPORTANT***********************////////////////////////
  //Set the data that needs to be added that the profile user doesnt contain
  void _onPressed() async {
    //members.add(widget.profileId);
    teamsRef
        .document(currentUser.id)
        .collection("usersTeam")
        .document(teamId)
        .setData({
      "name": teamNameController.text,
      "goal": teamGoalController.text,
      "leader": currentUser.id,
      "timestamp": timestamp,
    }).then((_) {
      print("success!");
    });
    setState(() {
      //Gives to postId a new Unique uid everytime a post is uploaded
      teamId = Uuid().v4();
    });
  }

  submit() async{
    final form = _formKey.currentState;
    if (form.validate()) {
       await form.save();

       Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
        //backgroundColor: Colors.amber,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey.shade50,
          actions: [
            Center(
                child: FaIcon(FontAwesomeIcons.palette,
                    color: Colors.grey.shade700)),
            SizedBox(
              width: 30.0,
            ),
            Center(
                child:
                    FaIcon(FontAwesomeIcons.font, color: Colors.grey.shade700)),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Name your team and set your common goal",
                            style: TextStyle(
                                fontSize: 29.0, fontFamily: "CabinSketch"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 25.0, left: 25.0, top: 15.0),
                          child: Container(
                            color: Colors.grey.shade50,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (val) {
                                      if (val.trim().length <= 1 ||
                                          val.isEmpty) {
                                        return "Team name is too short";
                                      } else if (val.trim().length > 30) {
                                        return "Team name is too long";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: teamNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Ex: Real Madrid",
                                      labelStyle: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: "Roboto-Light"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      if (val.trim().length <= 1 ||
                                          val.isEmpty) {
                                        return "Goal is too short";
                                      } else if (val.trim().length > 30) {
                                        return "Goal is too long";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: teamGoalController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Ex: Win the Champions League",
                                      labelStyle: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: "Roboto-Light"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    submit();
                    _onPressed();


                  },
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Submit team",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontFamily: "Questrial-Regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
