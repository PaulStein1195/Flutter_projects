import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udem_post/models/user.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/screens/team_screen.dart';
import 'package:udem_post/widgets_global/data_card.dart';
import 'package:udem_post/widgets_global/header.dart';
import 'package:udem_post/widgets_global/progress.dart';
import '../constants.dart';
import 'package:intl/intl.dart';

class Team extends StatefulWidget {
  final String teamId;
  final String name;
  final String leader;
  final String goal;
  final List members;
  final Timestamp groupCreated;

  Team({
    this.teamId,
    this.name,
    this.leader,
    this.members,
    this.groupCreated,
    this.goal,
  });

  factory Team.fromDocument(DocumentSnapshot doc) {
    return Team(
      teamId: doc["teamId"],
      name: doc["name"],
      leader: doc["leader"],
      goal: doc["goal"],
      members: doc["members"],
      groupCreated: doc["groupCreated"],
    );
  }

  @override
  _TeamState createState() => _TeamState(
        teamId: this.teamId,
        name: this.name,
        leader: this.leader,
        goal: this.goal,
        members: this.members,
        groupCreated: this.groupCreated,
      );
}

class _TeamState extends State<Team> {
  final String currentUserId = currentUser?.id;
  final String teamId;
  final String name;
  final String leader;
  final String goal;
  final List members;
  final Timestamp groupCreated;

  _TeamState({
    this.teamId,
    this.name,
    this.leader,
    this.members,
    this.groupCreated,
    this.goal,
  });

  buildDashboardHeader() {
    return FutureBuilder(
      future: usersRef.document(currentUser.id).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Team team = Team.fromDocument(snapshot.data);
        return ListView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: Colors.yellow.shade600, width: 1.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => showTeam(context,
                                          teamId: teamId, leader: leader),
                                      child: Text(
                                        widget.name,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey),
                            SizedBox(height: 7.0),

                            //Divider(color: Colors.grey,),
                            SizedBox(height: 10.0),
                            Text(
                              "GOAL : " + ' " ' + widget.goal + ' " ',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Row(
              children: [
                Expanded(
                  child: Data_Container_small(headerText: "POSTS"),
                ),
                Expanded(
                  child: Data_Container_small(
                    headerText: "RESULTS",
                  ),
                ),
              ],
            ),*/
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 230,
      child: Column(
        children: [
          buildDashboardHeader(),
        ],
      ),
    );
  }
}

showTeam(BuildContext context, {String teamId, String leader}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return TeamScreen(
      teamId: teamId,
      leader: leader,
    );
  }));
}
