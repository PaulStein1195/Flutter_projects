import 'package:bonfire_newbonfire/screens/Access/widgets/amber_btn_widget.dart';
import 'package:bonfire_newbonfire/screens/Access/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:bonfire_newbonfire/service/snackbar_service.dart';
import 'package:provider/provider.dart';

class Register2Screen extends StatefulWidget {
  //final String name;
  //final File image;

 // Register2Screen({this.name});

  @override
  _Register2ScreenState createState() => _Register2ScreenState(
    //name: this.name,
  );
}

class _Register2ScreenState extends State<Register2Screen> {
  GlobalKey<FormState> _formKey;
  AuthProvider _auth;
  String _name;
  String _email;
  String _password;
  bool _obscureText = true;


  _Register2ScreenState(/*{this.name}*/) {
    _formKey = GlobalKey<FormState>();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance,
            child: registerUI(),
          )),
    );
  }

  Widget registerUI() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        _auth = Provider.of<AuthProvider>(_context);
        return Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState.save();
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Text_Form_Widget("Username"),
                  TextFormField(
                    style:
                    TextStyle(color: Colors.grey.shade200, fontSize: 20.0),
                    textAlign: TextAlign.center,
                    onSaved: (_input) {
                      setState(() {
                        _name = _input;
                      });
                    },
                    decoration: kTextFieldDecoration.copyWith(),
                    validator: (_input) {
                      return _input.length != 0 && _input.length > 6
                          ? null
                          : "Username need more than 6 characters";
                    },
                  ),
                  SizedBox(height: 8.0),

                  Text_Form_Widget("Email"),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style:
                    TextStyle(color: Colors.grey.shade200, fontSize: 20.0),
                    textAlign: TextAlign.center,
                    onSaved: (_input) {
                      setState(() {
                        _email = _input;
                      });
                    },
                    decoration: kTextFieldDecoration.copyWith(
                    ),
                    validator: (_input) {
                      return _input.length != 0 && _input.contains("@")
                          ? null
                          : "Please enter a valid email";
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text_Form_Widget("Password"),
                  TextFormField(
                    obscureText: _obscureText,
                    style:
                    TextStyle(color: Colors.grey.shade200, fontSize: 20.0),
                    textAlign: TextAlign.center,
                    onSaved: (_input) {
                      setState(() {
                        _password = _input;
                      });
                    },
                    decoration: kTextFieldDecoration.copyWith(),
                    validator: (_input) {
                      return _input.length != 0 && _input.length > 6
                          ? null
                          : "Password need more than 6 characters";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                        splashRadius: 0.1,
                        onPressed: _toggle,
                        icon: _obscureText
                            ? Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.white70,
                              )
                            : Icon(
                                Icons.check_box,
                                color: Colors.white70,
                              ),
                      ),
                        Text(
                            "Show password",
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: registerButton(),
                  ),
                  Text(
                    "This will validate  your autheticity to keep a healthy platform.",
                    style: TextStyle(color: Colors.grey, fontSize: 17.0),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget registerButton() {
    return _auth.status == AuthStatus.Authenticating
        ? Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    )
        : Amber_Btn_Widget(
      context: context,
      text: "REGISTER",
      onPressed: () {
        //Implement registration functionality.

        if (_formKey.currentState.validate() != null) {
          _auth.registerUserWithEmailAndPassword(_email, _password,
                  (String _uid) async {
                await DBService.instance
                    .createUserInDB(_uid, _name, _email, "", "");
              });
        }
        //Navigator.pushNamed(context, HomeScreen.id);
      },
    );
  }
}



