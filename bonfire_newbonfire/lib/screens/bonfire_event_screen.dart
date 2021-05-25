import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class BonfireEvent extends StatefulWidget {
  final String title, description, time;
  final Color iconColor;
  final IconData icon;
  final bool isLive;

  BonfireEvent(
      {this.title,
      this.description,
      this.time,
      this.icon,
      this.iconColor,
      this.isLive});

  @override
  _BonfireEventState createState() => _BonfireEventState(
      title: this.title,
      description: this.description,
      time: this.time,
      icon: this.icon,
      iconColor: this.iconColor,
      isLive: this.isLive);
}

class _BonfireEventState extends State<BonfireEvent> {
  final String title, description, time;
  final Color iconColor;
  final IconData icon;
  final bool isLive;

  _BonfireEventState(
      {this.title,
      this.description,
      this.time,
      this.icon,
      this.iconColor,
      this.isLive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF333333).withOpacity(0.8).withBlue(50),
      //Colors.orange.shade600.withOpacity(0.8),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 30.0,
            automaticallyImplyLeading: true,
            centerTitle: true,
            backgroundColor: Color(0XFF333333),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(MyFlutterApp.share),
              )
            ],
          ),

          //elevation: 0.0,
          //title:

          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(color: Color(0XFF333333)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  this.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22.0),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white70,
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    this.description,
                                    style: TextStyle(
                                      fontSize: 21.5,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isLive
                                ? SizedBox(
                                    height: 10.0,
                                  )
                                : SizedBox(),
                            isLive
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              "LIVE",
                                              style: TextStyle(
                                                  color: Colors.grey.shade200,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(""),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        /**/
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Overview",
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white70),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Divider(
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Attending: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          /*CircleAvatar(
                                            radius: 20.0,
                                            backgroundColor:
                                                Colors.lightBlueAccent,
                                            backgroundImage: AssetImage(
                                                "assets/images/user1.jpg"),
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.lightBlueAccent,
                                            backgroundImage: AssetImage(
                                                "assets/images/user2.jpg"),
                                            radius: 20.0,
                                          ),*/
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            "220 members",
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Duration: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          /*CircleAvatar(
                                            radius: 20.0,
                                            backgroundColor:
                                                Colors.lightBlueAccent,
                                            backgroundImage: AssetImage(
                                                "assets/images/user1.jpg"),
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.lightBlueAccent,
                                            backgroundImage: AssetImage(
                                                "assets/images/user2.jpg"),
                                            radius: 20.0,
                                          ),*/
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            "30 mins",
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Colors.orange.shade700,
                                    //Theme.of(context).accentColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    elevation: 1.0,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      minWidth: 180.0,
                                      height: 42.0,
                                      child: Text(
                                        "JOIN",
                                        style: TextStyle(
                                            fontSize: 17.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
