import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/bonfire.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/bonfire_event_screen.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:bonfire_newbonfire/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../my_flutter_app_icons.dart';
import '../display_post_page.dart';

AuthProvider _auth;

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: AuthProvider.instance,
      child: Builder(
        builder: (BuildContext context) {
          _auth = Provider.of<AuthProvider>(context);
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                 /* SliverAppBar(
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
                  ),*/
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
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
                                                  itemCount: _usersData.length,
                                                  itemBuilder:
                                                      (BuildContext _context,
                                                          int _index) {
                                                    print(
                                                        _usersData[_index].name);
                                                    print(_usersData[_index].uid);
                                                    var _userData =
                                                        _usersData[_index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.0),
                                                      child: ListTile(
                                                        onTap: () {
//Go to profile
                                                        },
                                                        title: Text(
                                                          _userData.name,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                                                              fit: BoxFit.cover,
                                                              image: _userData
                                                                          .profileImage ==
                                                                      null
                                                                  ? AssetImage("")
                                                                  : NetworkImage(
                                                                      _userData
                                                                          .profileImage),
                                                            ),
                                                          ),
                                                          child: _userData
                                                                      .profileImage !=
                                                                  null
                                                              ? Center(
                                                                  child: Text(
                                                                    _userData
                                                                        .name[0],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20.0,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700),
                                                                  ),
                                                                )
                                                              : Text(""),
                                                        ),
                                                        trailing: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Text(
                                                              timeago.format(
                                                                _userData.lastSeen
                                                                    .toDate(),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize: 13,
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
                                    child: SpinKitFadingFour(
                                      size: 50.0,
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
          );
        },
      ),
    );
  }
}
