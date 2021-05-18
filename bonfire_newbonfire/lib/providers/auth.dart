import 'package:bonfire_newbonfire/model/user.dart';
import 'package:bonfire_newbonfire/screens/home_screen.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bonfire_newbonfire/service/navigation_service.dart';
import 'package:bonfire_newbonfire/service/snackbar_service.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

//Creating a class to host all the AuthProvider functionality
class AuthProvider extends ChangeNotifier {

  FirebaseUser user;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthStatus status;
  FirebaseAuth _auth; //Internal variable to call firebase auth
  static AuthProvider instance =
  AuthProvider(); //Create static member of our class to only allow one AuthProvider

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _checkCurrentUserIsAuthenticated();
  }

  void _autoLogin() {
    if (user != null) {
      NavigationService.instance.navigateToReplacement("home");
    }
  }

  void _checkCurrentUserIsAuthenticated() async {
    user = await _auth.currentUser();
    if (user != null) {
      notifyListeners();
      _autoLogin();
    }
  }

  //Functions of our class
  void loginUserWithEmailAndPassword(String _email, String _password,
      context) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("Welcome ${user.email}");
      //TODO: Update lastSeen
      //NavigationService.instance.navigateToReplacement("loading");
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } catch (error) {
      status = AuthStatus.Error;

      if (user == null) {
        SnackBarService.instance.showSnackBarError("Account doesn't exist");
      } else {
        SnackBarService.instance.showSnackBarError(
            "Check that your email and password are correct");
      }
    }
    notifyListeners();
  }






  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);
      SnackBarService.instance.showSnackBarSuccess("Signed in successfully");
      user.sendEmailVerification();
      NavigationService.instance.navigateToReplacement("email_verification");
      //NavigationService.instance.goBack();
      //NavigationService.instance.navigateToReplacement(LoadingScreen.id);

    } catch (error) {
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance
          .showSnackBarError("Error while registering user");
    }
    notifyListeners();
  }

  void signUpGoogle() async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        "email",
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    User _user = User();
    print("User detected");
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      AuthResult _authResult = await _auth.signInWithCredential(credential);
      print("Result saved");
      if (_authResult.additionalUserInfo.isNewUser) {
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.name = _authResult.user.displayName;
        _user.profileImage = _authResult.user.photoUrl;
        print("User about to be created");
        DBService.instance.createUserGoogle(_user);
        status = AuthStatus.Authenticated;
        NavigationService.instance.navigateToReplacement("email_verification");
      }
      notifyListeners();
    } catch (e) {
      print("Error from Google $e");
    }
  }

  void logoutUser(Future<void> onSuccess()) async {
    try {
      await _auth.signOut();
      user = null;
      status = AuthStatus.NotAuthenticated;
      await onSuccess();
      await NavigationService.instance.navigateToReplacement("welcome");
      SnackBarService.instance.showSnackBarSuccess("Logged Out Successfully!");
    } catch (e) {
      SnackBarService.instance.showSnackBarError("Error Logging Out");
    }
    notifyListeners();
  }
}
