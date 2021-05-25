import 'dart:io';

import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:bonfire_newbonfire/home_screen.dart';
import 'package:bonfire_newbonfire/screens/Access/widgets/amber_btn_widget.dart';
import 'package:bonfire_newbonfire/screens/Floating_create/create_post.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'my_flutter_app_icons.dart';


class ShareInBF extends StatefulWidget {
  const ShareInBF({Key key}) : super(key: key);

  @override
  _ShareInBFState createState() => _ShareInBFState();
}

class _ShareInBFState extends State<ShareInBF> {
  String _image, _title, _description, _postId = Uuid().v4(), url;
  double _height, _width;
  bool isUploadingPost = false;
  String _information = '';
  AuthProvider _auth;
  File file;

  final _formKey = new GlobalKey<FormState>();


  void updateInformation(String information) {
    setState(() => _information = information);
  }

  void moveToSecondPage() async {
    final information = await     showDialog(
        context: (context),
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0))),
            backgroundColor: Color(0XFF333333),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    showDialogContent(bonfire: "Drones", onTap: () {
                      Navigator.pop(context, "Drones");
                    }),

                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(bonfire: "Software", onTap: (){
                      Navigator.pop(context, "Software");
                    }),

                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(bonfire: "Hardware", onTap: () {
                      Navigator.pop(context, "Hardware");
                    }),

                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(bonfire: "Drones", onTap: () {
                      Navigator.pop(context, "Drones");
                    }),
                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(bonfire: "HJ", onTap: () {
                      Navigator.pop(context, "HJ");

                    }),

                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey.shade100,
                  size: 30.0,
                ),
              ),
            ],
          );
        });
    updateInformation(information);
  }


  clearImage() {
    setState(() {
      file = null;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
    storageRef.child("post_$_postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  handleTakePhoto() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 500,
    );
    setState(() {
      this.file = file;
    });
  }

  //Same as handleTakePhoto but getting it from phone gallery
  handleChooseFromGallery() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF333333),
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: Builder(
              builder: (BuildContext context) {
                _auth = Provider.of<AuthProvider>(context);
                return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //_postCategory(),
                        _postItContentUI(),
                        //_smartContentSpace(),
                        _addContentDisplayUI(),
                        SizedBox(
                          height: 40.0,
                        ),
                        _submitPostButton(),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ),
    );
  }


  Widget _postItContentUI() {
    return Container(
      width: _width,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState.save();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Select Bonfire',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Material(
                    color: Colors.grey.shade600,
                    //color: Colors.orange.shade600,//Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    elevation: 3.0,
                    child: MaterialButton(
                        onPressed: () {
                          moveToSecondPage();

                        },
                        minWidth: 60.0,
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/flame2_white.png"))),
                            ),
                            //SizedBox(width: 20.0,),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 35.0,
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 30.0,),
                  Text(_information, style: TextStyle(color: Colors.white, fontSize: 25.0),)
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Topic',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20.0,
              ),
              _titleTextField(),
              SizedBox(
                height: 20.0,
              ),
              _descriptionTextField(),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Add Content',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20.0,
              ),
              _smartContentSpace()
            ],
          ),
        ),
      ),
    );
  }
  Widget _addContentDisplayUI() {
    return file == null ? Text("") : _contentSpace();
  }

  Widget _contentSpace() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width * 0.9,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(file),
                )),
          ),
        ),
      ),
    );
  }
  Widget _smartContentSpace() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 25.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        width: _width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _smartIcon(icon: MyFlutterApp.camera_1, onPressed: handleTakePhoto),
            SizedBox(
              width: 20.0,
            ),
            _smartIcon(icon: MyFlutterApp.photo, onPressed: handleChooseFromGallery),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  /*Widget _addContentDisplayUI() {
    return file == null ? Text("") : _contentSpace();
  }*/

  Widget _submitPostButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: isUploadingPost
          ? CircularProgressIndicator()
          : Amber_Btn_Widget(
              context: context,
              text: "POST",
              onPressed: isUploadingPost
                  ? null
                  : () async {
                setState(() {
                  isUploadingPost = true;
                });
                String _mediaUrl = await uploadImage(file);
                if(_mediaUrl == null){
                  _mediaUrl = "";
                } else {
                  DBService.instance.createPostInDB(_auth.user.uid, _postId,
                      _image, _title, _description, _mediaUrl);
                  titleController.clear();
                  descriptionController.clear();
                  setState(() {
                    _postId = Uuid().v4();
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()));
                }
              },
            ),
    );
  }

  Widget _smartIcon({IconData icon, Function onPressed}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
              topLeft: Radius.circular(5.0))),
      height: 50.0,
      width: 50.0,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 30.0,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

Widget showDialogContent({String bonfire, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.start,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              gradient: LinearGradient(colors: [
                //Theme.of(context).accentColor,
                Colors.blueAccent,
                Colors.lightBlueAccent
              ],
                  begin: Alignment.topLeft, end: Alignment.bottomLeft

              ),
              color: Colors.white, //Theme.of(context).accentColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  gradient: LinearGradient(colors: [
                    Colors.blueAccent,
                    Colors.lightBlueAccent
                  ],
                      begin: Alignment.topLeft, end: Alignment.bottomLeft

                  ),
                  image: DecorationImage(
                      image: AssetImage("assets/images/flame_icon1.png")),
                  color: Colors.white70, //Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            bonfire,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 17.0),
          )
        ],
      ),
    );
}

  Widget _titleTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: _width,
        child: TextFormField(
          validator: (_input) {
            return _input.isEmpty ? "Need to title your Post" : null;
          },
          onSaved: (_input) {
            return _title = _input;
          },
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          controller: titleController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(color: Colors.white70, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              labelText: "Title your post",
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: 15, fontFamily: "PT-Sans", color: Colors.white70)),
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: _width,
        child: TextFormField(
          validator: (_input) {
            return _input.isEmpty ? "Need to describe briefly your Post" : null;
          },
          onSaved: (_input) {
            return _description = _input;
          },
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          minLines: 2,
          maxLines: 4,
          controller: descriptionController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(color: Colors.white70, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              labelText: "Explain your post",
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: 15, fontFamily: "PT-Sans", color: Colors.white70)),
        ),
      ),
    );
  }
}
