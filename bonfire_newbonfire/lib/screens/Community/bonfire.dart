import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/post.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/BF_Categories/select_bonfires_screen.dart';
import 'package:bonfire_newbonfire/screens/Home/going.dart';
import 'package:bonfire_newbonfire/screens/Home/homepage(test).dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:bonfire_newbonfire/widget/scrollable_bf_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../inbox.dart';
import '../../my_flutter_app_icons.dart';
import '../../notifications.dart';

AuthProvider _auth;

class BonfireScreen extends StatefulWidget {
  @override
  _BonfireScreenState createState() => _BonfireScreenState();
}

class _BonfireScreenState extends State<BonfireScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: AuthProvider.instance,
      child: Builder(
        builder: (BuildContext context) {
          _auth = Provider.of<AuthProvider>(context);
          return DefaultTabController(
            length: 1,
            child: Scaffold(
              floatingActionButton: kFloatingAction(context),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0), // here the desired height
                child: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    indicatorColor: Colors.orange,
                    unselectedLabelColor: Colors.white38,
                    tabs: [
                      TabTitle("That's fire"),
                      //TabTitle("Divulgation"),
                    ],
                  ),
                  backgroundColor: kFirstAppbarColor,
                  elevation: 0.0,
                ),
              ),
              body: TabBarView(children: [
                SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            StreamBuilder<List<Post>>(
                                stream: DBService.instance.getTechTimeline(),
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
                                      ],
                                    );
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                stream: DBService.instance.getNatureTimeline(),
                                builder: (context, _snapshot) {
                                  var _data = _snapshot.data;
                                  if (!_snapshot.hasData || _data.length == 0) {
                                    return SizedBox();
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            "Nature",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
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
                                stream: DBService.instance.getHealthTimeline(),
                                builder: (context, _snapshot) {
                                  var _data = _snapshot.data;
                                  if (!_snapshot.hasData || _data.length == 0) {
                                    return SizedBox();
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            "Health",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: _data.toList(),
                                      )
                                    ],
                                  );
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, bottom: 2.0),
                                    child: Text(
                                      "Suggested Bonfires",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.grey.shade300,
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
                                            SelectBonfireScreen(),
                                      ),
                                    ),
                                    child: Text(
                                      "+   See all",
                                      style: TextStyle(
                                          color: Color(0XFFF78C01),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    "New users",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25.0),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  child: StreamBuilder<List<User>>(
                                    stream: DBService.instance.getUsersInDB(),
                                    builder: (_context, _snapshot) {
                                      var _usersData = _snapshot.data;

                                      if (_usersData != null) {
                                        _usersData.removeWhere((_contact) =>
                                            _contact.uid == _auth.user.uid);
                                      }
                                      return _snapshot.hasData
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 500,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          _usersData.length,
                                                      itemBuilder: (BuildContext
                                                              _context,
                                                          int _index) {
                                                        print(_usersData[_index]
                                                            .name);
                                                        print(_usersData[_index]
                                                            .uid);
                                                        var _userData =
                                                            _usersData[_index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      12.0),
                                                          child: ListTile(
                                                            onTap: () {
//Go to profile
                                                            },
                                                            title: Text(
                                                              _userData.name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            leading: Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white70,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: _userData
                                                                              .profileImage ==
                                                                          null
                                                                      ? AssetImage(
                                                                          "")
                                                                      : NetworkImage(
                                                                          _userData
                                                                              .profileImage),
                                                                ),
                                                              ),
                                                              child: _userData
                                                                          .profileImage !=
                                                                      null
                                                                  ? Center(
                                                                      child:
                                                                          Text(
                                                                        _userData
                                                                            .name[0],
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ),
                                                                    )
                                                                  : Text(""),
                                                            ),
                                                            trailing: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  timeago
                                                                      .format(
                                                                    _userData
                                                                        .lastSeen
                                                                        .toDate(),
                                                                  ),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: CircularProgressIndicator(
                                                color: kAmberColor,
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
