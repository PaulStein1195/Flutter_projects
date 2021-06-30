import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/RTC/enter_channel.dart';
import 'package:bonfire_newbonfire/screens/bonfire_event_screen.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

AuthProvider _auth;

class OurTrends extends StatefulWidget {
  String description, bonfire, time;
  IconData icon, bfIcon;
  Color iconColor;
  bool isLive;

  OurTrends(
      {this.description,
      this.bonfire,
      this.time,
      this.icon,
      this.bfIcon,
      this.iconColor,
      this.isLive});

  @override
  _OurTrends createState() => _OurTrends();
}

class _OurTrends extends State<OurTrends> {
  bool isPressed = false;
  bool isSharing = false;
  String text = "Bonfire";
  String subject = "Link subject";

  get description => null;

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isLive == false
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BonfireEvent(
                    isLive: this.widget.isLive,
                    description: this.widget.description,
                    time: this.widget.time,
                    icon: this.widget.icon,
                    iconColor: this.widget.iconColor,
                  ),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        JoinScreen(description: this.widget.description)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: kMainBoxColor,
            border: Border.all(color: Colors.grey.shade800),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white70),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  widget.bfIcon,
                                  color: Colors.white70,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  widget.bonfire,
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.isLive == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "LIVE",
                                        style: TextStyle(
                                            color: Colors.grey.shade200,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.time,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  Text(
                                    " pm",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    backgroundColor: Color(0XFF333333),
                                    children: [
                                      SimpleDialogOption(
                                          onPressed: () {
                                            //TODO: get link and share
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.error,
                                                color: Colors.white70,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Text(
                                                "Report",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )),
                                      SimpleDialogOption(
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              Icon(
                                                MyFlutterApp.trash,
                                                color: Colors.white70,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Text(
                                                "Don't show",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )),
                                      SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.grey.shade100,
                                          size: 25.0,
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Icon(
                              MyFlutterApp.ellipsis_v,
                              size: 20.0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.description,
                          style: TextStyle(
                              color: Colors.grey.shade50,
                              fontSize: 17.5,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 9.0),
                ChangeNotifierProvider<AuthProvider>.value(
                  value: AuthProvider.instance,
                  child: Builder(
                    builder: (BuildContext context) {
                      _auth = Provider.of<AuthProvider>(context);
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "HOSTS : ",
                                style: TextStyle(
                                    //decoration: TextDecoration.underline,
                                    color: Colors.orange,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
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
                                  ? /*Row(
                                      children: [
                                        Text(
                                          "HOST :",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.orange,
                                              fontSize: 20.5,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 20.0,),
                                        Container(
                                          height: 50.0,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('assets/images/logo_shadow.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Text(
                                          _usersData.length.toString(),
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.grey.shade200),
                                        ),
                                      ],
                                    )*/
                                  SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _usersData.length,
                                              itemBuilder:
                                                  (BuildContext _context,
                                                      int _index) {
                                                print(_usersData[_index].name);
                                                print(_usersData[_index].uid);
                                                var _userData =
                                                    _usersData[_index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12.0,
                                                          right: 25.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50.0,
                                                        width: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                _userData
                                                                    .profileImage),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        _userData.name
                                                            .substring(
                                                          0,
                                                          _userData.name
                                                              .indexOf(" "),
                                                        ),
                                                        style: TextStyle(
                                                            fontSize: 16.0),
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: widget.isLive == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                Icon(
                                  MyFlutterApp.users,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text(
                                    "220",
                                    style: TextStyle(
                                      color: Colors.white70,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                MyFlutterApp.download,
                                size: 25.0,
                                color: isPressed == true
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isPressed == true) {
                                    isPressed = false;
                                  } else if (isPressed == false) {
                                    isPressed = true;
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                MyFlutterApp.share,
                                size: 22.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                share(context);
                              },
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                MyFlutterApp.download,
                                size: 25.0,
                                color: isPressed == true
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isPressed == true) {
                                    isPressed = false;
                                  } else if (isPressed == false) {
                                    isPressed = true;
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                MyFlutterApp.share,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                share(context);
                              },
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
