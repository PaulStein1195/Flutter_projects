import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/screens.dart';
import '../../inbox.dart';
import '../../my_flutter_app_icons.dart';
import '../../notifications.dart';


//final postRef = Firestore.instance.collection("Posts");
//final userRef = Firestore.instance.collection("Users");
AuthProvider _auth;

class HomepageScreen extends StatefulWidget {
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool noData = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: kFloatingAction(context),
        appBar: AppBar(
          bottom: TabBar(
            automaticIndicatorColorAdjustment: false,
            indicatorColor: Colors.orange,
            unselectedLabelColor: Colors.white38,
            tabs: [
              TabTitle("Happening"),
              TabTitle("Going"),
            ],
          ),
          backgroundColor: kFirstAppbarColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
            icon: Icon(
              MyFlutterApp.magnifier,
              size: 25.0,
            ),
          ),
          actions: [
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              splashColor: Colors.white70,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => InboxScreen())),
              icon: Icon(
                MyFlutterApp.envelope,
                size: 27.0,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            /*Stack(
              children: [
                IconButton(
                  splashColor: Colors.white70,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NotificationsScreen(),
                    ),
                  ),
                  icon: Icon(
                    MyFlutterApp.alarm,
                    size: 27.0,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.center,
                    child: Text('2'),
                  ),
                ),
              ],
            ),*/
            SizedBox(
              width: 5.0,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            WhatsHappeningScreen(),
            GoingScreen(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme:
          theme.primaryIconTheme.copyWith(color: kFirstBackgroundColor),
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }

  final bonfires = [
    "Software",
    "Hardware",
    "Web Servers",
    "Drones",
    "Technology",
    "Arts",
    "Music",
    "Crytpcurrency"
  ];
  final recentBonfires = ["Software", "Hardware", "Web Servers", "Drones"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BonfireScreen(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentBonfires
        : bonfires.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestions = suggestionList[index];
        return ListTile(
          onTap: () {
            query = suggestions;
            showResults(context);
          },
          leading: Icon(
            MyFlutterApp.fire_1,
            color: Colors.white,
          ),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}

Widget TabTitle(String title) {
  return Tab(
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 19,
          color: Colors.grey.shade100,
          fontWeight: FontWeight.w700),
    ),
  );
}
