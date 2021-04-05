import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:udem_post/Menus/Dashboard/dashboard.dart';
import 'package:udem_post/Menus/Notifications/notifications.dart';
import 'package:udem_post/models/user.dart';
import 'package:udem_post/screens/Create_team/database_getUser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../home.dart';
import 'package:uuid/uuid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchUsers extends StatefulWidget {
  final String teamId;
  final User user;
  final String profileId;

  SearchUsers({this.teamId, this.user, this.profileId});

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Future<QuerySnapshot> searchResultsFuture;
  TextEditingController searchTextEditingController =
      new TextEditingController();
  TextEditingController searchController = TextEditingController();
  int countUsers = 0;
  bool wasPressed = false;
  final String currentUserId = currentUser?.id;


  handleSearch(String query) {
    Future<QuerySnapshot> users = usersRef
        .where("username", isGreaterThanOrEqualTo: query)
        .getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  joinTeam() async {
    await teamsRef.document(currentUserId).collection("usersTeam").document(widget.teamId).updateData({
      "members" : FieldValue.arrayUnion(["generous","loving","loyal"])
    }).then((_) {
      print("success!");
    });
  }


  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
        List<Add_User> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser.id == user.id;
          if (isAuthUser) {
            return;
          }
          Add_User userResult = Add_User(
            user: user,
            size: wasPressed == true ? 46.0 : 40,
            icon: wasPressed == true
                ? CupertinoIcons.check_mark_circled_solid
                : CupertinoIcons.person_add_solid,
            color: wasPressed == true ? Colors.green : Colors.grey,
            onPressed: () {
              setState(() {
                if (wasPressed == false) {
                  wasPressed = true;
                  countUsers++;
                  joinTeam();
                } else if (wasPressed == true) {
                  wasPressed = false;
                  countUsers--;
                }
              });
            },
          );
          searchResults.add(userResult);
        });
        return Expanded(
            child: ListView(shrinkWrap: true, children: searchResults));
      },
    );
  }

  /*clearSearch() {
    searchController.clear();
  }*/

  AppBar buildSearchField() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      title: TextFormField(
        controller: searchTextEditingController,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade50,
          hintText: "Search for a user...",
          filled: true,
          prefixIcon: Icon(
            Icons.account_box,
            size: 25.0,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: buildSearchField(),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Container(
                height: 55.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor.withOpacity(0.7),
                    border: Border.all(
                        color: Colors.blueGrey.shade300, width: 1.2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Users: " + countUsers.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade50,
                          fontSize: 18.0,
                          fontFamily: "Questrial-Regular",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 55.0,
                            height: 38.0,
                            child: FaIcon(
                              FontAwesomeIcons.arrowRight,
                              size: 18,
                              color: Colors.blueGrey.shade50,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(15.0),
                                border:
                                    Border.all(color: Colors.blueGrey.shade50)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildSearchResults(),
          ],
        ),
      ),
    );
  }
}

////////////////////////////// SHOWS LAYOUT ONCE IT FINDS USERS RESULTS

class UserResult extends StatelessWidget {
  final User user;
  String teamId = Uuid().v4();

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 400.0,
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: GestureDetector(
              onTap: () => showProfile(context, profileId: user.id),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
            ),
            title: GestureDetector(
              onTap: () => showProfile(context, profileId: user.id),
              child: Text(
                user.username,
                style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.8), fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(
              user.email,
              style: TextStyle(color: Colors.grey.shade400.withOpacity(0.8)),
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}

class Add_User extends StatelessWidget {
  final User user;
  final Function onPressed;
  final IconData icon;
  final Color color;
  final double size;

  Add_User(
      {@required this.user, this.onPressed, this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 400.0,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: GestureDetector(
              onTap: () => showProfile(context, profileId: user.id),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
            ),
            title: Text(
              user.username,
              style: TextStyle(
                  color: Colors.blueGrey.shade700, fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              user.username,
              style: TextStyle(color: Colors.blueGrey.withOpacity(0.8)),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(icon, size: size, color: color),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
