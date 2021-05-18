import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/question.dart';
import 'package:bonfire_newbonfire/screens/bonfire_screen.dart';
import 'package:bonfire_newbonfire/screens/user_access/widgets/amber_btn_widget.dart';
import 'package:bonfire_newbonfire/widget/trends.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_newbonfire/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../email_screen.dart';
import '../my_flutter_app_icons.dart';
import '../notifications_screen.dart';
import 'bf_categories/select_bonfires_screen.dart';
import 'main_bonfire/WH_screen.dart';
import 'new_user/widgets/scrollable_bf_widget.dart';

final postRef = Firestore.instance.collection("Posts");
final userRef = Firestore.instance.collection("Users");
AuthProvider _auth;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool noData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kFloatingAction(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromRGBO(41, 39, 40, 180.0),
            expandedHeight: 40.0,
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
              /*IconButton(
                splashColor: Colors.white70,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AllUsers())),
                icon: Icon(
                  MyFlutterApp.users,
                  size: 27.0,
                ),
              ),*/
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                splashColor: Colors.white70,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EmailScreen())),
                icon: Icon(
                  MyFlutterApp.mail,
                  size: 27.0,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                splashColor: Colors.white70,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NotificationsScreen())),
                icon: Icon(
                  MyFlutterApp.alarm,
                  size: 27.0,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "What's Happening",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w600),
                      ),
                      FlatButton(
                        splashColor: Colors.white70,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      WH_Screen()));
                        },
                        child: Text(
                          "+ Show more",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Trends(
                    trendImage: "https://picsum.photos/250?image=11",
                    title: "Drones",
                    description: "Revolution in air transportation?",
                    time: "02:30 PM",
                    icon: MyFlutterApp.rss,
                    iconColor: Colors.greenAccent.shade700),
                SizedBox(
                  height: 20.0,
                ),
                /*Trends(
                    trendImage: "https://picsum.photos/250?image=11",
                    title: "NVIDIA",
                    score: "Advancing towards autonomous systems",
                    time: "02:15 PM",
                    icon: MyFlutterApp.share,
                    iconColor: Colors.white70),
                SizedBox(
                  height: 5.0,
                ),*/
                /* Trends(
                    trendImage: "https://picsum.photos/250?image=11",
                    title: "COVID-19",
                    score: "Vaccination, PROS and CONS from Science and experience",
                    time: "05:00 PM",
                    icon: MyFlutterApp.share,
                    iconColor: Colors.white70),*/

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "You are going",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w600),
                      ),
                      FlatButton(
                        splashColor: Colors.white70,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      WH_Screen()));
                        },
                        child: Text(
                          "+ Show more",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                /*Trends(
                  trendImage: "https://picsum.photos/250?image=11",
                  title: "NVIDIA",
                  score: "Advancing towards autonomous systems",
                  time: "02:15 PM",
                  icon: MyFlutterApp.share,
                  iconColor: Colors.white70,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Trends(
                    trendImage: "https://picsum.photos/250?image=11",
                    title: "NVIDIA",
                    score: "Advancing towards autonomous systems",
                    time: "02:15 PM",
                    icon: MyFlutterApp.share,
                    iconColor: Colors.white70),
                SizedBox(
                  height: 5.0,
                ),*/
                Trends(
                    trendImage: "https://picsum.photos/250?image=11",
                    title: "COVID-19",
                    description:
                        "Vaccination, PROS and CONS from Science and experience",
                    time: "05:00 PM",
                    icon: MyFlutterApp.share,
                    iconColor: Colors.white70),
                SizedBox(
                  height: 5.0,
                ),
                /*FlatButton(
                  splashColor: Colors.white70,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => WH_Screen()));
                  },
                  child: Text(
                    "+ Show more",
                    style: TextStyle(
                        color: kAmberColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Timeline",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                ChangeNotifierProvider<AuthProvider>.value(
                  value: AuthProvider.instance,
                  child: Builder(
                    builder: (BuildContext context) {
                      _auth = Provider.of<AuthProvider>(context);
                      return StreamBuilder<List<Post>>(
                        stream: DBService.instance.getMyPosts(_auth.user.uid),
                        builder: (context, _snapshot) {
                          var _data = _snapshot.data;
                          if (!_snapshot.hasData) {
                            return Center(
                              child: SpinKitFadingFour(
                                size: 50.0,
                                color: kAmberColor,
                              ),
                            );
                          }
                          if (_data.length == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade800

                                    //color: Color(0XFF717171),
                                  ),
                                  color: Color.fromRGBO(41, 39, 40, 10.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/start_fire.png")
                                          )
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "NOTHING IN YOUR TIMELINE!",
                                      style: TextStyle(
                                          fontSize: 23.5, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                                      child: Amber_Btn_Widget(
                                        context: context,
                                        text: "START",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => FirstSuggestionScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: _data.toList(),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ChangeNotifierProvider<AuthProvider>.value(
                  value: AuthProvider.instance,
                  child: Builder(
                    builder: (BuildContext context) {
                      _auth = Provider.of<AuthProvider>(context);
                      return StreamBuilder<List<Question>>(
                        stream: DBService.instance.getQuestions(_auth.user.uid),
                        builder: (context, _snapshot) {
                          var _data = _snapshot.data;
                          if (!_snapshot.hasData) {
                            return Center(
                              child: SpinKitFadingFour(
                                size: 50.0,
                                color: kAmberColor,
                              ),
                            );
                          }
                          if (_data.length == 0) {
                            return Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 0.0, color: Colors.white70),
                              ),
                            );
                          }
                          return Column(
                            children: _data.toList(),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 2.0),
                        child: Text(
                          "Suggested Bonfires",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: FlatButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FirstSuggestionScreen(),
                          ),
                        ),
                        child: Text(
                          "+   See all",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Scrollable_BF_Widget(),
              ],
            ),
          )
        ],
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
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.black87),
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
            MyFlutterApp.candle_fire,
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
