import 'package:flutter/material.dart';
import 'package:udem_post/constants.dart';

PreferredSize header(context, {bool isAppTitle = false, String titleText}) {
  return PreferredSize(
    preferredSize: isAppTitle ? Size.fromHeight(55.0) : Size.fromHeight(45.0),
    child: AppBar(
      automaticallyImplyLeading:  false,
      centerTitle: true,
      title: Text(isAppTitle ? "UrOpinion" : titleText,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontWeight: isAppTitle ? FontWeight.w400 : FontWeight.w500,
            fontFamily: isAppTitle ? "Pacifico" : "PT-Sans",
            fontSize: isAppTitle ? 25.0 : 20.0,
          ),
          overflow: TextOverflow.ellipsis),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
