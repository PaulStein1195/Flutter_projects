import 'package:bonfire_newbonfire/widget/ourTrend.dart';
import 'package:bonfire_newbonfire/widget/skeletonHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_newbonfire/model/post.dart';
import '../../my_flutter_app_icons.dart';

final postRef = Firestore.instance.collection("Posts");
final userRef = Firestore.instance.collection("Users");
AuthProvider _auth;

class GoingScreen extends StatelessWidget {
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
                                          height: 15.0,
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
                                        height: 5.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2.0),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      OurTrends(
                                          trendImage:
                                              "https://picsum.photos/250?image=11",
                                          title: "COVID-19",
                                          description:
                                              "Vaccination, PROS and CONS from Science and experience",
                                          time: "5:00",
                                          icon: MyFlutterApp.share,
                                          iconColor: Colors.white70,
                                          isLive: false),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      OurTrends(
                                          trendImage:
                                              "https://picsum.photos/250?image=11",
                                          title: "COVID-19",
                                          description:
                                              "Vaccination, PROS and CONS from Science and experience",
                                          time: "5:00",
                                          icon: MyFlutterApp.share,
                                          iconColor: Colors.white70,
                                          isLive: false),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      OurTrends(
                                          trendImage:
                                              "https://picsum.photos/250?image=11",
                                          title: "COVID-19",
                                          description:
                                              "Vaccination, PROS and CONS from Science and experience",
                                          time: "5:00",
                                          icon: MyFlutterApp.share,
                                          iconColor: Colors.white70,
                                          isLive: false),
                                      SizedBox(
                                        height: 40.0,
                                      ),
                                      /*Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 30.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "Suggested Bonfires",
                                                  textAlign:
                                                  TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.grey
                                                          .shade300,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  right: 5.0),
                                              child: FlatButton(
                                                onPressed: () =>
                                                    Navigator.push(
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
                                                      color: Color(
                                                          0XFFF78C01),
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                        Scrollable_BF_Widget(),*/
                                    ],
                                  );
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

Widget buildSkeleton(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SkeletonContainer.rounded(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 15,
                  ),
                  const SizedBox(height: 8),
                  SkeletonContainer.rounded(
                    width: 60,
                    height: 13,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  SkeletonContainer.rounded(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SkeletonContainer.rounded(
                    width: 50,
                    height: 30,
                  ),
                  SkeletonContainer.rounded(
                    width: 50,
                    height: 30,
                  ),
                  SkeletonContainer.rounded(
                    width: 50,
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
