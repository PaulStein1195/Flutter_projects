import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/test/meeting_screen.dart';
import 'package:flutter/material.dart';

class BonfireEvent extends StatefulWidget {
  final String title, description, time;
  final Color iconColor;
  final IconData icon;

  BonfireEvent(
      {this.title, this.description, this.time, this.icon, this.iconColor});

  @override
  _BonfireEventState createState() => _BonfireEventState(
      title: this.title,
      description: this.description,
      time: this.time,
      icon: this.icon,
      iconColor: this.iconColor);
}

class _BonfireEventState extends State<BonfireEvent> {
  final String title, description, time;
  final Color iconColor;
  final IconData icon;

  _BonfireEventState(
      {this.title, this.description, this.time, this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /*SliverAppBar(
            expandedHeight: 150.0,
            automaticallyImplyLeading: false,
            title: Text(
              this.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(41, 39, 40, 140.0),
          ),*/

          //elevation: 0.0,
          //title:

          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            //Color.fromRGBO(41, 39, 40, 140.0),
                            Colors.blue.shade800,
                            Colors.blue
                          ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        MyFlutterApp.share,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    this.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 24.0),
                                  ),
                                  Divider(
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    this.description,
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0XFF222327)),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),

                                ),
                                color: Color(0XFF333333)//Color(0XFF222327),
                              ),
                              child: Column(
                                children: [
                                  /*Text(
                                this.title,
                                style: TextStyle(
                                    fontSize: 23.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),*/
                                  /*Text(
                                this.description,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.orange.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),*/
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 47.0,
                                                width: 90.0,
                                                child: Material(
                                                  color: Colors.orange.shade600,
                                                  //color: Color(0XFFffb21a),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                  child: MaterialButton(
                                                    elevation: 5.0,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) =>
                                                                  MeetingScreen()));
                                                    },
                                                    child: Text(
                                                      "JOIN",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 17.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "LIVE",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Icon(
                                                    this.icon,
                                                    color: this.iconColor,
                                                    size: 25.0,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Divider(color: Colors.grey.shade700,),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Attending: ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                  fontWeight: FontWeight.bold

                                              ),
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
                                                    CircleAvatar(
                                                      radius: 25.0,
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
                                                      radius: 25.0,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      "+ 18 others",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Description: ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                /*SizedBox(
                  height: 10.0,
                ),*/
                /*Container(
                  decoration: BoxDecoration(
                    color: Color(0XFF222327),
                    border: Border.all(
                        //color: Color(0XFF333333),

                        //color: Color(0XFF717171),
                        ),
                    //borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      /*Text(
                          this.title,
                          style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),*/
                      /*Text(
                          this.description,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.orange.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),*/
                      Divider(
                        color: Colors.white70,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Status: ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "LIVE",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                this.icon,
                                color: this.iconColor,
                                size: 25.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Attending: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
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
                                      CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.lightBlueAccent,
                                        backgroundImage: AssetImage(
                                            "assets/images/user1.jpg"),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.lightBlueAccent,
                                        backgroundImage: AssetImage(
                                            "assets/images/user2.jpg"),
                                        radius: 25.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "+ 18 others",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Description: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
