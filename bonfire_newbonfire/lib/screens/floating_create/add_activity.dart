import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/screens/floating_create/create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../my_flutter_app_icons.dart';

class SelectPost extends StatelessWidget {
  Widget buildBonfireList(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(41, 39, 40, 80.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Software",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hardware",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Drones",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Mechanics",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Software",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Software",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreatePostPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Software",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 23.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 39, 40, 150.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 39, 40, 180.0),
        title: Text(
          "Create Activity",
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 500,
              color: Color.fromRGBO(41, 39, 40, 140.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Column(
                  children: [
                    Text(
                      "Discuss over a topic?",
                      style: TextStyle(color: Colors.white70, fontSize: 27.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 111.0,
                        width: 111.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Theme.of(context).accentColor,
                                  Colors.orange
                                ]),
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 111.0,
                            width: 111.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/flame_icon1.png")),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Theme.of(context).accentColor,
                                      Colors.orange
                                    ]),
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(100.0)),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "DIVULGE",
                      style: TextStyle(color: Colors.white, fontSize: 23.0),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 500,
              color: Color.fromRGBO(41, 39, 40, 140.0),
              child: Column(
                children: [
                  Text(
                    "Share content on the bonfire?",
                    style: TextStyle(color: Colors.white70, fontSize: 27.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.black87,
                                    context: context,
                                    builder: buildBonfireList);
                              },
                              child: Container(
                                height: 111.0,
                                width: 111.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Theme.of(context).accentColor,
                                          Colors.orange
                                        ]),
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Icon(
                                  MyFlutterApp.pencil,
                                  size: 45.0,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            Text(
                              "POST",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
