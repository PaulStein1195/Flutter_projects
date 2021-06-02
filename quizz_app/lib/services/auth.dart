import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//GETTERS: ONE TIME FUTURE CALL OR STREAMING USERS DATA FOR UPDATED CHANGES
  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  /// Sign in with Google
  Future<FirebaseUser> googleSignIn() async {

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      return user;
      // Update user data
      updateUserData(user);

  }

  Future<void> updateUserData (FirebaseUser user) {
    DocumentReference reportRef = _db.collection("reports").document(user.uid);
    return reportRef.setData({
      'uid': user.uid,
      'lastActivity': DateTime.now()
    }, merge: true);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

}