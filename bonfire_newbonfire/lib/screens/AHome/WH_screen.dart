import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/widget/trends_showmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WH_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "What's Happening",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(41, 39, 40, 140.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(color: Color(0XFFF28500)
                  //border: Border.all(color: Colors.white70)
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        MyFlutterApp.calendar,
                        size: 25.0,
                      )),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "Explore calendar",
                    style: TextStyle(
                      fontSize: 23.5,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Today",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Trends_Detailed("https://picsum.photos/250?image=11", "Technology",
                "Create a Start up in SV"),
            SizedBox(
              height: 10.0,
            ),
            Trends_Detailed("https://picsum.photos/250?image=11", "Technology",
                "Create a Start up in SV"),
            SizedBox(
              height: 10.0,
            ),
            Trends_Detailed("https://picsum.photos/250?image=11", "Technology",
                "Create a Start up in SV"),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Tomorrow",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Trends_Detailed("https://picsum.photos/250?image=11", "Technology",
                "Create a Start up in SV"),
            SizedBox(
              height: 10.0,
            ),
            Trends_Detailed("https://picsum.photos/250?image=11", "Technology",
                "Create a Start up in SV"),
            SizedBox(
              height: 10.0,
            ),
            Trends_Detailed("https://picsum.photos/250?image=11", "Technology",
                "Create a Start up in SV"),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
