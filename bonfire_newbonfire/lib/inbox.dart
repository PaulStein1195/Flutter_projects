import 'package:bonfire_newbonfire/screens/Access/widgets/amber_btn_widget.dart';
import 'package:flutter/material.dart';
import 'const/color_pallete.dart';
import 'my_flutter_app_icons.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kFirstAppbarColor,
          centerTitle: true,
          title: Text(
            "Inbox",
            style: TextStyle(color: Colors.white70),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Container(
                height: 250.0,
                width: 300.0,
                decoration: BoxDecoration(
                    color: kFirstAppbarColor,
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        MyFlutterApp.envelope,
                        color: Colors.white70,
                        size: 70.0,
                      ),
                      Column(
                        children: [
                          Text(
                            "Inbox",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Empty!",
                            style:
                                TextStyle(fontSize: 28.0, color: kAmberColor),
                          ),
                        ],
                      )

                      /*Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/Logo.png")
                          )
                      ),
                    ),*/
                    ],
                  ),
                ),
              ),
            ),
            Amber_Btn_Widget(
                context: context,
                text: "GO BACK",
                onPressed: () => Navigator.pop(context))
          ],
        ));
  }
}
