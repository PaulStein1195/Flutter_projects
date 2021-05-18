import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String bio;
  String profileImage;

  Timestamp lastSeen;

  User({this.uid, this.name, this.email, this.profileImage, this.bio, this.lastSeen});

  factory User.fromDocument(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;
    return User(
      uid: _snapshot.documentID,
      name: _data["name"],
      email: _data["email"],
      profileImage: _data["profileImage"],
      bio: _data["bio"],
      lastSeen: _data["lastSeen"],
    );
  }
}
