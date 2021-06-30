import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String bio;
  int bonfires;
  int posts;
  String profileImage;

  Timestamp lastSeen;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.bio,
    required this.bonfires,
    required this.posts,
    required this.lastSeen});

  factory User.fromDocument(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;
    return User(
      uid: _snapshot.documentID,
      name: _data["name"],
      email: _data["email"],
      profileImage: _data["photo"],
      bio: _data["bio"],
      bonfires: _data["bonfires"],
      posts: _data["posts"],
      lastSeen: _data["lastSeen"],
    );
  }
}
