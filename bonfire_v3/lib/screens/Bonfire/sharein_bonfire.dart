import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../my_flutter_app_icons.dart';
/*
final StorageReference storageRef = FirebaseStorage.instance.ref();

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
  String _pickCategory, _pickBonfire;
  AuthProvider _auth;
  File file;

  final _formKey = new GlobalKey<FormState>();

  void updateInformation(String information) {
    setState(() => _information = information);
  }

  void moveToSecondPage() async {
    final information = await showDialog(
        context: (context),
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Color(0XFF333333),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showDialogContent(
                      category: "Technology",
                      bonfire: "Drones",
                      onTap: () {
                        _pickCategory = "Technology";
                        _pickBonfire = "Drones";
                        Navigator.pop(context, _pickBonfire);
                      },
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(
                      category: "Technology",
                      bonfire: "Software",
                      onTap: () {
                        _pickCategory = "Technology";
                        _pickBonfire = "Software";
                        Navigator.pop(context, _pickBonfire);
                      },
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(
                      category: "Technology",
                      bonfire: "Hardware",
                      onTap: () {
                        _pickCategory = "Technology";
                        _pickBonfire = "Hardware";
                        Navigator.pop(context, _pickBonfire);
                      },
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(
                      category: "Nature",
                      bonfire: "Climate Change",
                      onTap: () {
                        _pickCategory = "Nature";
                        _pickBonfire = "Climate Change";
                        Navigator.pop(context, _pickBonfire);
                      },
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(
                      category: "Nature",
                      bonfire: "Animals",
                      onTap: () {
                        _pickCategory = "Nature";
                        _pickBonfire = "Animals";
                        Navigator.pop(context, _pickBonfire);
                      },
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    showDialogContent(
                        category: "Health",
                        bonfire: "Exercise",
                        onTap: () {
                          _pickCategory = "Health";
                          _pickBonfire = "Exercise";
                          Navigator.pop(context, _pickBonfire);
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
      appBar: AppBar(
        backgroundColor: kFirstAppbarColor,
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
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add title',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  _submitPostButton(),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _descriptionTextField(),
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
      padding: const EdgeInsets.only(top: 12.0, bottom: 5.0),
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
      padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: [
                _smartIcon(icon: MyFlutterApp.camera, onPressed: handleTakePhoto),
                SizedBox(
                  width: 20.0,
                ),
                _smartIcon(
                    icon: MyFlutterApp.photo, onPressed: handleChooseFromGallery),
                SizedBox(
                  width: 30.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Text(
                              "Bonfire",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 25.0,
                          )
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20.0,
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
                      if (_mediaUrl == null) {
                        _mediaUrl = "";
                      } else {
                        DBService.instance.createPostInDB(
                            _auth.user.uid,
                            _postId,
                            _image,
                            _title,
                            _description,
                            _pickCategory,
                            _pickBonfire,
                            _mediaUrl);
                        titleController.clear();
                        descriptionController.clear();
                        setState(() {
                          _postId = Uuid().v4();
                        });
                        await Firestore.instance
                            .collection("Users")
                            .document(_auth.user.uid)
                            .updateData({"posts": FieldValue.increment(1)});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomeScreen()));
                      }
                    },
            ),
    );
  }

  Widget _smartIcon({IconData icon, Function onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25.0
            /*bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
          topLeft: Radius.circular(5.0),*/
            ),
      ),
      height: 55.0,
      width: 55.0,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25.0,
          color: kMainBoxColor,
        ),
      ),
    );
  }

  Widget showDialogContent({String category, String bonfire, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: category == "Technology"
                  ? Colors.blue
                  : category == "Nature"
                      ? Colors.green
                      : category == "Health"
                          ? Colors.orange
                          : Color(0XFF333333), //Theme.of(context).accentColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                      image: AssetImage("assets/images/flame_icon1.png")),
                  color: category == "Technology"
                      ? Colors.blue
                      : category == "Nature"
                          ? Colors.green
                          : category == "Health"
                              ? Colors.orange
                              : Color(
                                  0XFF333333), //Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            bonfire,
            style: TextStyle(color: Colors.white70, fontSize: 17.0),
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
          maxLines: 3,
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
              labelText: "Ex: Drones - The future of human transportation",
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: 15, fontFamily: "PT-Sans", color: Colors.white70)),
        ),
      ),
    );
  }
}
*/