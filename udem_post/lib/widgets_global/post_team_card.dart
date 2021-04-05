import 'package:flutter/material.dart';
import 'package:udem_post/constants.dart';



class Card_Option extends StatelessWidget {
  Card_Option(
      {@required this.title, this.description, this.icon, this.onPressed});

  String title;
  String description;
  IconData icon;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 7.0,
      child: new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.yellow.shade50,
            Colors.grey.shade50,
            Colors.grey.shade50
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        height: 245,
        width: 300,
        padding: new EdgeInsets.all(15.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                  fontSize: 28.0,
                  color: kButtons,
                  fontFamily: "Questrial-Regular"),
            ),
            Divider(
              color: Colors.grey.shade700,
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: new Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Roboto-Light",
                    fontWeight: FontWeight.w500),
              ),
            ),

            new MaterialButton(
              onPressed: onPressed,
              child: Container(
                padding: EdgeInsets.all(11.0),
                child: Icon(icon, size: 42.0, color: Colors.white,),
              ),
              color: kButtons,
              shape: CircleBorder(),
              elevation: 6.0,
            ),
          ],
        ),
      ),
    );
  }
}
