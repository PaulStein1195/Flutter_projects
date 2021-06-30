import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../my_flutter_app_icons.dart';
/*
AuthProvider _auth;

class OthersProfile extends StatefulWidget {
  final String profileId;

  OthersProfile({this.profileId});

  @override
  _OthersProfileState createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile> {
  bool notificationOff = false;
  final String currentUserId = currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(41, 39, 40, 200.0),
            expandedHeight: 55.0,
            title: Text(
              "",
              style: TextStyle(color: Colors.white70),
            ),
            automaticallyImplyLeading: true,
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
          stream: DBService.instance.getUserData(widget.profileId),
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
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                      //color: Color.fromRGBO(41, 39, 40, 150.0),
                      /*gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          kAmberColor,
                          Colors.red,
                        ],
                      ),*/
                      /*image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _image != ""
                              ? NetworkImage(_image)
                              : AssetImage("assets/images/flame_icon1.png")),*/
                    ),
                    child: Center(
                        child: Text(
                      _name[0],
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        _name,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: kTitlesrelevant),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            splashColor: Colors.white70,
                            onPressed: () {},
                            icon: Icon(
                              MyFlutterApp.envelope,
                              size: 27.0,
                              color: kTitlesrelevant,
                            ),
                          ),
                          Text("Send message", style: TextStyle(color: kTitlesrelevant),), SizedBox(width: 10.0,)
                        ],
                      )
                    ),
                  ],
                ),
                SizedBox(
                  width: 30.0,
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
    return StreamBuilder<List<Post>>(
      stream: DBService.instance.getMyPosts(_auth.user.uid),
      builder: (_context, _snapshot) {
        var _userInfoData = _snapshot.data;
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
              buildCountColumn("Bonfires", 0),
              buildCountColumn("Teams", 0),
              buildCountColumn("Posts", _userInfoData.length),
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

*/