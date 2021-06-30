import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String bio;
  int bonfires;
  int posts;
  String profileImage;

  Timestamp lastSeen;

  UserModel({required this.uid, required this.name, required this.email, required this.profileImage, required this.bio, required this.bonfires, required this.posts, required this.lastSeen});

  factory UserModel.fromDocument(DocumentSnapshot _snapshot) {
    return UserModel(
      uid: _snapshot.id,
      name: _snapshot["name"],
      email: _snapshot["email"],
      profileImage: _snapshot["profileImage"],
      bio: _snapshot["bio"],
      bonfires: _snapshot["bonfires"],
      posts: _snapshot["posts"],
      lastSeen: _snapshot["lastSeen"],
    );
  }
}
