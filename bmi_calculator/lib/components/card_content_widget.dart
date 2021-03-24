import 'package:flutter/material.dart';
import '../constants.dart';
const iconSize = 80.0;


class cardGenderContent extends StatelessWidget {
  final String gender;
  final IconData icon;

  cardGenderContent({@required this.icon, this.gender});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        SizedBox(height: 15.0),
        Text(
          gender,
          style: kLabelText,
        )
      ],
    );
  }
}