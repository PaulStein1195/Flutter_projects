import 'package:bonfire_newbonfire/const/color_pallete.dart';
import 'package:bonfire_newbonfire/screens/Profile/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:provider/provider.dart';
import '../../my_flutter_app_icons.dart';

AuthProvider _auth;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(41, 39, 40, 200.0),
            expandedHeight: 55.0,
            title: Text(
              "Me",
              style: TextStyle(color: Colors.white70),
            ),
            automaticallyImplyLeading: false,
            actions: [
              Icon(MyFlutterApp.lightbulb,
                  size: 25.0, color: Colors.white //kBottomNavigationBar,
                  ),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SettingsScreen()));
                },
                icon: Icon(MyFlutterApp.settings, size: 25.0),
                color: Colors.white, //kBottomNavigationBar,
              ),
              SizedBox(
                width: 5.0,
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ChangeNotifierProvider<AuthProvider>.value(
                  value: AuthProvider.instance,
                  child: _buildProfileView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return StreamBuilder<User>(
          stream: DBService.instance.getUserData(_auth.user.uid),
          builder: (_context, _snapshot) {
            var _userData = _snapshot.data;
            if (!_snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: kAmberColor,
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  _userProfileData(_userData.name, _userData.email,
                      _userData.profileImage, _userData.bio),
                  _userCollectedData(),
                  Divider(color: Colors.white70),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      /*gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.deepOrange,
                          Colors.orange,
                          Theme.of(context).accentColor
                        ],
                      ),*/
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2.5),
                      child: Row(
                        children: [
                          Icon(
                            MyFlutterApp.pie_chart,
                            size: 25.0,
                            color: Colors.grey.shade100,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Games",
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      /*gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.deepOrange,
                          Colors.orange,
                          Theme.of(context).accentColor
                        ],
                      ),*/
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2.5),
                      child: Row(
                        children: [
                          Icon(
                            MyFlutterApp.lightbulb,
                            size: 25.0,
                            color: Colors.grey.shade100,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Tools",
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget _userProfileData(
      String _name, String _email, String _image, String _bio) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "edit_profile"),
      child: Card(
        color: Color.fromRGBO(41, 39, 40, 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                        image: NetworkImage(_image)
                      )
                    ),
                    /*child: Center(
                      child: Text(
                        _name[0],
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),*/
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0),
                    ),
                    Text(
                      _email,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17.0,
                          letterSpacing: 0.25),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30.0,
                ),
                Icon(
                  MyFlutterApp.pencil,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bio",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    _bio,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white70, fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCollectedData() {
    return StreamBuilder<User>(
      stream: DBService.instance.getUserData(_auth.user.uid),
      builder: (_context, _snapshot) {
        var _userData = _snapshot.data;
        if (!_snapshot.hasData) {
          return CircularProgressIndicator(
            color: kAmberColor,
          );
        }
        //DEBUGGING: print(_snapshot.data.length);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildCountColumn("Bonfires", _userData.bonfires),
              buildCountColumn("Teams", 0),
              buildCountColumn("Posts", _userData.posts),
              buildCountColumn("Rated", 0),
              //buildCountColumn("followers", 0),
            ],
          ),
        );
      },
    );
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
