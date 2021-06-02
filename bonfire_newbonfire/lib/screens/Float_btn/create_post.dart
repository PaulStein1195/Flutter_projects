import 'dart:io';
import 'package:bonfire_newbonfire/home.dart';
import 'package:bonfire_newbonfire/screens/Access/widgets/amber_btn_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bonfire_newbonfire/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_newbonfire/service/db_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

final postRef = Firestore.instance.collection("Posts");
final StorageReference storageRef = FirebaseStorage.instance.ref();

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  double _height, _width;
  String _image, _title, _description, _postId = Uuid().v4(), url;
  String _pickCategory, _bonfire;
  AuthProvider _auth;
  File file;
  bool isUploadingPost = false, isImgInPost = true;
  List<bool> categoryState = [false, false, false, false];

  final _formKey = new GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Post"),
        backgroundColor: Color.fromRGBO(41, 39, 40, 200.0),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: postPageUI(),
        ),
      ),
    );
  }

  Widget postPageUI() {
    return Builder(
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
                  _smartContentSpace(),
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
              SizedBox(height: 20.0,),
              /*Text(
                'Title',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),*/
              _titleTextField(),
              SizedBox(height: 20.0,),

              /*Text(
                'Description',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),*/
              _descriptionTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _smartContentSpace() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        width: _width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _smartIcon(Icons.add_a_photo, handleTakePhoto),
            SizedBox(
              width: 20.0,
            ),
            _smartIcon(Icons.add_photo_alternate, handleChooseFromGallery),
            //_smartIcon(Icons.share, Color(0xFF10ac84), "btnShare", () {}),
            //_smartIcon(Icons.computer, Color(0xFF10ac84), "btnAI", () {}),
          ],
        ),
      ),
    );
  }

  Widget _addContentDisplayUI() {
    return file == null ? Text("") : _contentSpace();
  }

  Widget _submitPostButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: isUploadingPost
          ? CircularProgressIndicator()
          : Amber_Btn_Widget(
              context: context,
              text: "POST IT",
              onPressed: isUploadingPost
                  ? null
                  : () async {
                      setState(() {
                        isUploadingPost = true;
                      });
                      String _mediaUrl = await uploadImage(file);
                      if(_mediaUrl.isEmpty){
                        _mediaUrl = "";
                      } else {
                        DBService.instance.createPostInDB(_auth.user.uid, _postId,
                            _image, _title, _description, _pickCategory, _bonfire, _mediaUrl);
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

  Widget _smartIcon(IconData icon, Function onPressed) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0), topLeft: Radius.circular(5.0))),
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
          style: TextStyle(color: Colors.white, fontSize: 20.0),
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
          style: TextStyle(color: Colors.white, fontSize: 20.0),
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
              labelText: "Describe it",
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                  fontSize: 15, fontFamily: "PT-Sans", color: Colors.white70)),
        ),
      ),
    );
  }
}

