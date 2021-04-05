import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:udem_post/constants.dart';

class Data_Container_small extends StatelessWidget {
  String headerText;
  RaisedButton cardButton;

  Data_Container_small({this.headerText, this.cardButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.yellow.shade600, width: 1.2),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText,
            ),
          ),
          new CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              animation: true,
              percent: 0.5,
              center: new Text(
                "50.0%",
                style: new TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5,
                    color: Colors.blueGrey.shade700),
              ),
              /*footer: new Text(
                "YES",
                style: new TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.0,
                    color: Color(0xff004c8c)),
              ),*/
              circularStrokeCap: CircularStrokeCap.butt,
              progressColor: Colors.yellow.shade600,
              backgroundColor: Colors.yellow.shade100),
        ],
      ),
    );
  }
}
