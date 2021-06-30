import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/model/post.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/screens/screens.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AuthProvider _auth;

class NewBonfireScreen extends StatefulWidget {
  @override
  _NewBonfireScreenState createState() => _NewBonfireScreenState();
}

class _NewBonfireScreenState extends State<NewBonfireScreen> {
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
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      StreamBuilder<List<Post>>(
                          stream: DBService.instance.getTechTimeline(),
                          builder: (context, _snapshot) {
                            var _data = _snapshot.data;
                            if (!_snapshot.hasData) {
                              return Center(
                                child: Container(
                                  height: 500,
                                  width: 500,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.orange,
                                        ),
                                        SizedBox(height: 5.0,),
                                        Text("Burning data", style: TextStyle(fontSize: 20.0),)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 1.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(top: 30.0, bottom: 2.0),
                                          child: Text(
                                            "Bonfires",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.grey.shade300,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      /*Padding(
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
                          ),*/
                                    ],
                                  ),
                                  Divider(color: Colors.orange, thickness: 1.5,),
                                  SizedBox(height: 5.0,),
                                  OurSquareBF(),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    child: Text(
                                      "That's fire",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Divider(color: Colors.orange, thickness: 1.5,),
                                  Column(
                                    children: _data.toList(),
                                  )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 5.0,
                      ),
                      StreamBuilder<List<Post>>(
                          stream: DBService.instance.getNatureTimeline(),
                          builder: (context, _snapshot) {
                            var _data = _snapshot.data;
                            if (!_snapshot.hasData) {
                              return SizedBox();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Nature",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),*/
                                Column(
                                  children: _data.toList(),
                                )
                              ],
                            );
                          }),
                      SizedBox(
                        height: 5.0,
                      ),
                      StreamBuilder<List<Post>>(
                          stream: DBService.instance.getHealthTimeline(),
                          builder: (context, _snapshot) {
                            var _data = _snapshot.data;
                            if (!_snapshot.hasData) {
                              return SizedBox();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Health",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),*/
                                Column(
                                  children: _data.toList(),
                                )
                              ],
                            );
                          }),

                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, bottom: 2.0),
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
                      Scrollable_BF_Widget(),*/
                      SizedBox(
                        height: 5.0,
                      ),

                      /*Column(
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
                                        child: CircularProgressIndicator(
                                          color: kAmberColor,
                                        ),
                                      );
                              },
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
