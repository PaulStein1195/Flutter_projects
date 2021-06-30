import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../my_flutter_app_icons.dart';
import 'sharein_bonfire.dart';

class PickActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF333333),
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(41, 39, 40, 180.0),
        title: Text(
          "", //"Create Activity",
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Meet in a Bonfire",
                    style: TextStyle(color: Colors.grey.shade300, fontSize: 30.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 111.0,
                              width: 111.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [Colors.deepOrange, Colors.orange]),
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: Icon(
                                MyFlutterApp.sound,
                                size: 45.0,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          //Text(
                          //  "POST",
                          //  style: TextStyle(
                          //  color: Colors.white, fontSize: 23.0),
                          //),
                        ],
                      ),
                    ),
                  ),

                  //Text(
                  //  "DIVULGE",
                  //  style: TextStyle(color: Colors.white, fontSize: 23.0),
                  //),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Share in the Bonfire",
                    style: TextStyle(color: Colors.grey.shade300, fontSize: 30.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ShareInBF()));
                            },
                            child: Container(
                              height: 111.0,
                              width: 111.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [Colors.deepOrange, Colors.orange]),
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: Icon(
                                MyFlutterApp.pencil,
                                size: 45.0,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          //Text(
                          //  "POST",
                          //  style: TextStyle(
                          //  color: Colors.white, fontSize: 23.0),
                          //),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
