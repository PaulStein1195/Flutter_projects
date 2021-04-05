import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:udem_post/screens/Create_team/create_team.dart';
import 'package:udem_post/screens/create_post_it.dart';
import 'package:udem_post/screens/Create_team/search_users.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/widgets_global//header.dart';
import 'package:udem_post/widgets_global/post_team_card.dart';

class PostIt extends StatefulWidget {
  @override
  _PostItState createState() => _PostItState();
}

class _PostItState extends State<PostIt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF44414B),
      appBar: header(context, isAppTitle: false, titleText: "New Post"),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card_Option(
                title: "START TEAM",
                description:
                    'Add people, set your goals and try to engage everyone.',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateTeam())),
                icon: CupertinoIcons.group_solid,
              ),
              Card_Option(
                title: "CREATE POST IT",
                description:
                    'Describe your post, select the group and share your solutions. ',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePostIt(
                              currentUser: currentUser,
                            ))),
                icon: CupertinoIcons.create_solid,
              ),
            ]),
      ),
    );
  }
}

