import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/screens/bonfire_screen.dart';
import 'package:bonfire_newbonfire/widget/trends.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_newbonfire/model/post.dart';
import '../../inbox.dart';
import '../../my_flutter_app_icons.dart';
import '../../notifications.dart';
import '../BF_Categories/select_bonfires_screen.dart';
import 'WH_screen.dart';
import '../../widget/scrollable_bf_widget.dart';

final postRef = Firestore.instance.collection("Posts");
final userRef = Firestore.instance.collection("Users");
AuthProvider _auth;

class DisplayPostScreen extends StatefulWidget {
  @override
  _DisplayPostScreenState createState() => _DisplayPostScreenState();
}

class _DisplayPostScreenState extends State<DisplayPostScreen> {
  bool noData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kFloatingAction(context),
      body: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: Builder(
            builder: (BuildContext context) {
              _auth = Provider.of<AuthProvider>(context);
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: kFirstAppbarColor,
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
                      SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                        splashColor: Colors.white70,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InboxScreen())),
                        icon: Icon(
                          MyFlutterApp.mail,
                          size: 27.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Stack(
                        children: [
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
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              alignment: Alignment.center,
                              child: Text('2'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ChangeNotifierProvider<AuthProvider>.value(
                          value: AuthProvider.instance,
                          child: Builder(
                            builder: (BuildContext context) {
                              _auth = Provider.of<AuthProvider>(context);
                              //TODO: Display title of bonfire (category) and the list of documents userIDs
                              return StreamBuilder<List<Post>>(
                                stream: DBService.instance.getPostsInDB(),
                                builder: (context, _snapshot) {
                                  var _data = _snapshot.data;
                                  if (!_snapshot.hasData) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 150.0,
                                        ),
                                        CircularProgressIndicator(
                                          color: Colors.amber,
                                        ),
                                      ],
                                    );
                                  } else if (_data.length == 0) {
                                    /*return SpinKitFadingFour(
                                      color: Colors.amber,
                                      size: 50.0,
                                    );*/
                                  }
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "What's Happening",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.grey.shade300,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              FlatButton(
                                                splashColor: Colors.white70,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              WH_Screen()));
                                                },
                                                child: Text(
                                                  "+ Show more",
                                                  style: TextStyle(
                                                      color: Color(0XFFF78C01),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Trends(
                                          trendImage:
                                              "https://picsum.photos/250?image=11",
                                          title: "Drones",
                                          description:
                                              "Revolution in air transportation?",
                                          time: "2:30 PM",
                                          isLive: true,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Trends(
                                          trendImage:
                                          "https://picsum.photos/250?image=11",
                                          title: "Drones",
                                          description:
                                          "Revolution in air transportation?",
                                          time: "2:30 PM",
                                          isLive: true,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Trends(
                                          trendImage:
                                          "https://picsum.photos/250?image=11",
                                          title: "Drones",
                                          description:
                                          "Revolution in air transportation?",
                                          time: "2:30 PM",
                                          isLive: true,
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "You are going",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.grey.shade300,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              FlatButton(
                                                splashColor: Colors.white70,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              WH_Screen()));
                                                },
                                                child: Text(
                                                  "+ Show more",
                                                  style: TextStyle(
                                                      color: Color(0XFFF78C01),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Trends(
                                            trendImage:
                                                "https://picsum.photos/250?image=11",
                                            title: "COVID-19",
                                            description:
                                                "Vaccination, PROS and CONS from Science and experience",
                                            time: "5:00 PM",
                                            icon: MyFlutterApp.share,
                                            iconColor: Colors.white70,
                                            isLive: false),
                                        SizedBox(
                                          height: 40.0,
                                        ),
                                        /*Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey

                                                  //color: Color(0XFF717171),
                                                  ),
                                              color: Color.fromRGBO(
                                                  41, 39, 40, 10.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Column(
                                                children: [
                                                 Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Container(
                                                            height: 60.0,
                                                            width: 100.0,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/images/start_fire.png"))),
                                                          ),
                                                        ),
                                                        SizedBox(width: 30.0,),
                                                        Text(
                                                          "Explore Bonfires",
                                                          style: TextStyle(
                                                            fontSize: 23.5,
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  /*Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15.0),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 140.0),
                                                      child: Material(
                                                        color: Colors
                                                            .orange.shade700,
                                                        //Theme.of(context).accentColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        elevation: 2.0,
                                                        child: MaterialButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    SelectBonfireScreen(),
                                                              ),
                                                            );
                                                          },
                                                          minWidth: 260.0,
                                                          height: 10.0,
                                                          child: Text(
                                                            "START",
                                                            style: TextStyle(
                                                                letterSpacing:
                                                                    0.3,
                                                                fontSize: 16.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),*/
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                          child: Text(
                                            "Divulgation",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.grey.shade300,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        /*StreamBuilder<List<Post>>(
                                            stream: DBService.instance
                                                .getTechTimeline(),
                                            builder: (context, _snapshot) {
                                              var _data = _snapshot.data;
                                              if (!_snapshot.hasData ||
                                                  _data.length == 0) {
                                                return SizedBox();
                                              }

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
                                                      child: Text(
                                                        "Technology",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: _data.toList(),
                                                  )
                                                ],
                                              );
                                            }),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        StreamBuilder<List<Post>>(
                                            stream: DBService.instance
                                                .getNatureTimeline(),
                                            builder: (context, _snapshot) {
                                              var _data = _snapshot.data;
                                              if (!_snapshot.hasData ||
                                                  _data.length == 0) {
                                                return SizedBox();
                                              }

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
                                                      child: Text(
                                                        "Nature",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: _data.toList(),
                                                  )
                                                ],
                                              );
                                            }),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        StreamBuilder<List<Post>>(
                                            stream: DBService.instance
                                                .getHealthTimeline(),
                                            builder: (context, _snapshot) {
                                              var _data = _snapshot.data;
                                              if (!_snapshot.hasData ||
                                                  _data.length == 0) {
                                                return SizedBox();
                                              }

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
                                                      child: Text(
                                                        "Health",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: _data.toList(),
                                                  )
                                                ],
                                              );
                                            }),*/
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30.0, bottom: 2.0),
                                                child: Text(
                                                  "Suggested Bonfires",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      color:
                                                          Colors.grey.shade300,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: FlatButton(
                                                onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        SelectBonfireScreen(),
                                                  ),
                                                ),
                                                child: Text(
                                                  "+   See all",
                                                  style: TextStyle(
                                                      color: Color(0XFFF78C01),
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                      ]);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          )),
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
