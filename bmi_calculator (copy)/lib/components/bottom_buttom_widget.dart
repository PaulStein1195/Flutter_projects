import 'package:flutter/material.dart';

import '../constants.dart';

class BottomButtom extends StatelessWidget {
  final Function onTap;
  final String buttonTitle;

  BottomButtom({@required this.onTap, @required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Center(child: Text(buttonTitle, style: kLargeButtomTextStyle,)),
        margin: EdgeInsets.only(top: 10.0),
        color: kButtonColor,
        height: kBottomContainerHeight,
        width: double.infinity,
      ),
    );
  }
}