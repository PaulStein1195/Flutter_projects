import 'package:cloud_firestore/cloud_firestore.dart';

class Bonfire {
  String uid;


  Bonfire({this.uid});

  factory Bonfire.fromDocument(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;
    return Bonfire(
      uid: _snapshot.documentID,
    );
  }
}
