import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/screens/bonfire_event_screen.dart';
import 'package:flutter/material.dart';

class Trends extends StatelessWidget {
  String trendImage, title, description, time;
  IconData icon;
  Color iconColor;

  Trends(
      {this.trendImage,
      this.title,
      this.description,
      this.time,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    BonfireEvent(title: this.title, description: this.description, time: this.time, icon: this.icon, iconColor: this.iconColor,)));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(41, 39, 40, 10.0),
              border: Border.all(color: Colors.grey.shade700
                  //color: Color(0XFF717171),
                  ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(
                            MyFlutterApp.calendar,
                            size: 20.0,
                            color: Colors.grey.shade100,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          // Text("5:00 PM", style: TextStyle(fontSize: 20.0, color: Colors.white),)
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.5),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          icon,
                          color: iconColor,
                          size: 22.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        /*Container(
                          height: 30.0,
                          width: 80.0,
                          child: Material(
                            color: Color(0XFFffb21a),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: MaterialButton(
                              elevation: 5.0,
                              onPressed: () {},
                              child: Text(
                                "JOIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
ListTile(
leading: Column(
children: [
Icon(
MyFlutterApp.calendar,
size: 40.0,
color: Colors.white,
),
Text(
"5:00 PM",
style: TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.w700,
color: Colors.white),
),
// Text("5:00 PM", style: TextStyle(fontSize: 20.0, color: Colors.white),)
],
),
title: Text(
title,
style: TextStyle(
color: Colors.white70,
fontWeight: FontWeight.w700,
fontSize: 20.0),
),
subtitle: Text(
score,
style: TextStyle(
color: Theme.of(context).accentColor,
fontSize: 17,
fontWeight: FontWeight.w400),
),
trailing: Icon(
Icons.share,
color: Colors.white70,
),
),
*/
