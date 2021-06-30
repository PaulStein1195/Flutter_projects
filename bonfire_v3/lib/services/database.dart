import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bomfire_v3/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class DBService {
  static DBService instance = DBService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Firestore _db = Firestore.instance;

  String _userCollection = "users";

  Future<void> createBonfire(
      String bonfire, String bf_Id, String _subCollection, String uid) async {
    return await _db
        .collection(bonfire)
        .document(bf_Id)
        .collection(_subCollection)
        .document(uid)
        .setData({});
  }

  Stream<List<User>> getUsersInDB() {
    var _ref = _db.collection("users");
    return _ref.getDocuments().asStream().map((_snapshot) {
      return _snapshot.documents.map((_doc) {
        return User.fromDocument(_doc);
      }).toList();
    });
  }


  Stream<User> isUserInTech(String _userID) {
    var _ref = _db.collection("FollowingTech").document(_userID);
    return _ref.get().asStream().map((_snapshot) {
      return User.fromDocument(_snapshot);
    });
  }



  /*Future<void> createQuestion(String _uid, String _name, String _image,
      String _question, String _questionId) async {
    try {
      return await _db
          .collection(_questionCollection)
          .document(_uid)
          .collection("userQuestion")
          .document(_questionId)
          .setData({
        "ownerId": _uid,
        "questionId": _questionId,
        "name": _name,
        "image": _image,
        "question": _question,
        "timestamp": Timestamp.now(),
        "upgrade": {},
      });
    } catch (e) {
      print(e);
    }
  }*/

  Stream<User> getUserData(String _userID) {
    var _ref = _db.collection(_userCollection).document(_userID);
    return _ref.get().asStream().map((_snapshot) {
      return User.fromDocument(_snapshot);
    });
  }

}
