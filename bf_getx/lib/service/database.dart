import 'package:bf_getx/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class DBService {
  static DBService instance = DBService();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  String _userCollection = "Users";

  Stream<UserModel> getUserData(String _userID) {
    var _ref = _db.collection(_userCollection).doc(_userID);
    return _ref.get().asStream().map((_snapshot) {
      return UserModel.fromDocument(_snapshot);
    });
  }
}
