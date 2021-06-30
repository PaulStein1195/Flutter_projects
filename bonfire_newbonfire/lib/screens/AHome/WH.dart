import 'package:bonfire_newbonfire/my_flutter_app_icons.dart';
import 'package:bonfire_newbonfire/screens/shared/skeleton.dart';
import 'package:bonfire_newbonfire/service/navigation_service.dart';
import 'package:bonfire_newbonfire/widget/ourTrend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_newbonfire/model/post.dart';

//final postRef = Firestore.instance.collection("Posts");
//final userRef = Firestore.instance.collection("Users");
AuthProvider _auth;

class WhatsHappeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: Builder(
            builder: (BuildContext context) {
              _auth = Provider.of<AuthProvider>(context);
              return CustomScrollView(
                slivers: <Widget>[
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
                                          height: 10.0,
                                        ),
                                        buildSkeleton(context),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        buildSkeleton(context),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        buildSkeleton(context),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        buildSkeleton(context)
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
                                          height: 10.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                        ),
                                        OurTrends(
                                          bfIcon: MyFlutterApp.bitcoin,
                                          bonfire: "Crypto",
                                          description:
                                              "All the major cripto currencies going down",
                                          time: "2:30",
                                          isLive: true,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        OurTrends(
                                          bfIcon: MyFlutterApp.rocket,
                                          bonfire: "Space",
                                          description:
                                              "Drones - Revolution in air transportation?",
                                          time: "2:30",
                                          isLive: false,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        OurTrends(
                                          bfIcon: MyFlutterApp.atom,
                                          bonfire: "Science",
                                          description:
                                          "COVID-19 - Vaccination, PROS and CONS from Science and experience",
                                          time: "5:00",
                                          isLive: false,
                                        ),
                                        /*SizedBox(
                                          height: 50.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Colors.deepOrange,
                                                    Colors.orange,
                                                    Theme.of(context)
                                                        .accentColor
                                                  ],
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30.0,
                                                        vertical: 2.5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    NavigationService.instance
                                                        .navigateToReplacement(
                                                            "calendar");
                                                  },
                                                  child: Row(children: [
                                                    Icon(
                                                      MyFlutterApp
                                                          .calendar_full,
                                                      size: 30.0,
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      "Full Calendar",
                                                      style: TextStyle(
                                                          fontSize: 22.0,
                                                          color: Colors.white60,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),*/
                                        SizedBox(
                                          height: 50.0,
                                        ),
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
