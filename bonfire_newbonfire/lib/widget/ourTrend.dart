import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/screens/bonfire_event_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class OurTrends extends StatefulWidget {
  String trendImage, title, description, time;
  IconData icon;
  Color iconColor;
  bool isLive;

  OurTrends(
      {this.trendImage,
      this.title,
      this.description,
      this.time,
      this.icon,
      this.iconColor,
      this.isLive});

  @override
  _OurTrends createState() => _OurTrends();
}

class _OurTrends extends State<OurTrends> {
  bool isPressed = false;
  String text = "Bonfire";
  String subject = "Link subject";

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BonfireEvent(
                      isLive: this.widget.isLive,
                      title: this.widget.title,
                      description: this.widget.description,
                      time: this.widget.time,
                      icon: this.widget.icon,
                      iconColor: this.widget.iconColor,
                    )));
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.5),
                    ),
                    widget.isLive == true
                        ? Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "LIVE",
                                    style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                widget.time,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
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
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Text("#TECH", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
                      IconButton(
                        icon: Icon(
                          Icons.bookmark,
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
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.ellipsis,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  backgroundColor: Color(0XFF333333),
                                  /*title: Text(
                                                "You can",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                color: Theme.of(context).accentColor),
                                              ),*/
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
                                                  fontWeight: FontWeight.w600),
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
                                                  fontWeight: FontWeight.w600),
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
