import 'package:udem_post/models/post.dart';
import 'package:udem_post/models/team.dart';
import 'package:udem_post/models/user.dart';
import 'package:flutter/material.dart';
import 'package:udem_post/widgets_global/header.dart';
import 'package:udem_post/widgets_global/progress.dart';
import "home.dart";

class TeamScreen extends StatelessWidget {
  final String teamId;
  final String userId;
  final String leader;
  final User user;
  Team team;

  TeamScreen({this.teamId, this.user, this.userId, this.leader});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: commentsRef.document(teamId).collection("usersTeam").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Column(
          children: [
            Text(team.name)
          ],
        );
      },
    );
  }
}
