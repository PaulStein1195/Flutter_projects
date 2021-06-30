import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/RTC/enter_channel.dart';
import 'package:bonfire_newbonfire/screens/RTC/rtc_room.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

AuthProvider _auth;

class BonfireEvent extends StatefulWidget {
  final description, time;
  final Color iconColor;
  final IconData icon;
  final bool isLive;

  BonfireEvent(
      {this.description, this.time, this.icon, this.iconColor, this.isLive});

  @override
  _BonfireEventState createState() => _BonfireEventState(
      description: this.description,
      time: this.time,
      icon: this.icon,
      iconColor: this.iconColor,
      isLive: this.isLive);
}

class _BonfireEventState extends State<BonfireEvent> {
  final String description, time;
  final Color iconColor;
  final IconData icon;
  final bool isLive;

  _BonfireEventState(
      {this.description, this.time, this.icon, this.iconColor, this.isLive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // /backgroundColor: Color(0XFF333333).withOpacity(0.8).withBlue(50),
      //Colors.orange.shade600.withOpacity(0.8),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 30.0,
            automaticallyImplyLeading: true,
            centerTitle: true,
            backgroundColor: kMainBoxColor,
            /*actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(MyFlutterApp.share),
              )
            ],*/
          ),

          //elevation: 0.0,
          //title:

          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(color: kMainBoxColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    this.description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor,
                                        fontSize: 22.0),
                                    textAlign: TextAlign.center,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        /**/
                        ChangeNotifierProvider<AuthProvider>.value(
                          value: AuthProvider.instance,
                          child: Builder(
                            builder: (BuildContext context) {
                              _auth = Provider.of<AuthProvider>(context);
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "HOSTS",
                                        style: TextStyle(
                                            color: Colors.grey[100],
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 250.0),
                                    child: Divider(
                                      color: Colors.orange,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  StreamBuilder<List<User>>(
                                    stream: DBService.instance.getUsersInDB(),
                                    builder: (_context, _snapshot) {
                                      var _usersData = _snapshot.data;

                                      /*if (_usersData != null) {
                                        _usersData.removeWhere((_contact) =>
                                            _contact.uid == _auth.user.uid);
                                      }*/
                                      return _snapshot.hasData
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          _usersData.length,
                                                      itemBuilder: (BuildContext
                                                              _context,
                                                          int _index) {
                                                        print(_usersData[_index]
                                                            .name);
                                                        print(_usersData[_index]
                                                            .uid);
                                                        var _userData =
                                                            _usersData[_index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      17.0,
                                                                  horizontal:
                                                                      10.0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: 70.0,
                                                                width: 70.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(
                                                                            _userData.profileImage))),
                                                              ),
                                                              Text(
                                                                _userData.name
                                                                    .substring(
                                                                  0,
                                                                  _userData.name
                                                                      .indexOf(
                                                                          " "),
                                                                ),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17.5),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: CircularProgressIndicator(
                                                color: kAmberColor,
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "OVERVIEW",
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 250.0),
                                child: Divider(
                                  color: Colors.orange,
                                  thickness: 1.5,
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
