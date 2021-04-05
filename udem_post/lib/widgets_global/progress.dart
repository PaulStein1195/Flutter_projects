import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    child: CupertinoActivityIndicator(
      animating: true,
      radius: 20.0,
    ),
  );
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.orange),

    ),
  );
}