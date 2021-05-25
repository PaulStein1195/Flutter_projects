import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:flutter/material.dart';

class Scrollable_BF_Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(8, 2, 10, 5),
      child: Row(
        children: [
          BonfiresOptions("Software Programming"),
          BonfiresOptions("Memes"),
          BonfiresOptions("Education"),
          BonfiresOptions("Travel"),
        ],
      ),
    );
  }
}

Widget BonfiresOptions(
  String _bfname1,
) {
  return Column(
    children: [
      BonfireCategory(_bfname1, Colors.amber, Colors.orange.shade600),
      SizedBox(
        height: 5.0,
      ),
    ],
  );
}

Widget BonfireCategory(String _bf_name, Color color1, Color color2) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade800),
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(colors: [
              kMainBoxColor,
              Color(0XFF333333),
            ]),
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 42.0,
                    width: 42.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(colors: [
                        //Theme.of(context).accentColor,
                        color1,
                        color2
                      ], begin: Alignment.topLeft, end: Alignment.bottomLeft),
                      color: Colors.white, //Theme.of(context).accentColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: LinearGradient(
                              colors: [color1, color2],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft),
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/flame_icon1.png")),
                          color:
                              Colors.white70, //Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "$_bf_name",
                    style: TextStyle(color: Colors.grey.shade300, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
