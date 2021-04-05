import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udem_post/models/category.dart';
import 'package:udem_post/models/user.dart';
import 'package:udem_post/widgets_global//progress.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:udem_post/widgets_global/header.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants.dart';
import 'home.dart';

class CreatePostIt extends StatefulWidget {
  //Gets current user from User class
  final User currentUser;

  CreatePostIt({this.currentUser}); //Set current user in CreatePostIt class

  @override
  _CreatePostItState createState() => _CreatePostItState();
}

class _CreatePostItState extends State<CreatePostIt>
    with AutomaticKeepAliveClientMixin<CreatePostIt> {
  File file; //Creates a file named "file"
  bool isSubmitted = false; //Initialize the state of submitted of the new post
  String postId = Uuid()
      .v4(); //Assigns and specific Uuid to the post stored in the variable postId
  bool teamState = false;
  bool projectState = false;
  bool ideaState = false;
  bool problemState = false;

  //Used to get the values from TextField
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController solutionController = TextEditingController();

  //Future function to open the camera and store the image rewriting the "file" File
  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.file = file;
    });
  }

  //Same as handleTakePhoto but getting it from phone gallery
  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  //Function once the container of photo is pressed and Dialog is displayed
  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Center(
              child: Text(
                "Upload image",
                style: TextStyle(color: Color(0xff127681), fontSize: 22.0),
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Photo with camera"),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text("Image from gallery"),
                onPressed: handleChooseFromGallery,
              ),
            ],
          );
        });
  }

  Container buildUploadImage() {
    return Container(
      height: 220.0,
      width: MediaQuery.of(context).size.width * 0.8,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: FileImage(file),
          )),
        ),
      ),
    );
  }

  //List of Category with its topic and initial state
  List<bool> categorySelected = [false, false, false, false];

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File("$path/img_$postId.jpg")
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  ////**********************IMPORTANT***********************////////////////////////
  //Set the data that needs to be added that the profile user doesn't contain
  createPostInFirestore(
      {String mediaUrl,
      String title,
      String description,
      String solution,
      List<bool> category}) {
    postsRef
        .document(widget.currentUser.id)
        .collection("userPosts")
        .document(postId)
        .setData({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
      "title": title,
      "category": category.toString(),
      "description": description,
      "solution": solution,
      "timestamp": timestamp,
      "likes": {},
      "dislikes": {}
    });
  }

//While submitted the isSubmitted bool state sets to true, the image is compressed, the post is created(calling function), cleans the TextFields
  //Set files to null and submission again to false and changes the Uuid for next time not overwrite the data
  submitPost() async {
    setState(() {
      isSubmitted = true;
    });

    await compressImage();
    String mediaUrl = await uploadImage(file);

    createPostInFirestore(
      mediaUrl: mediaUrl,
      title: titleController.text,
      description: descriptionController.text,
      solution: solutionController.text,
      category: categoryState,
    );
    titleController.clear();
    descriptionController.clear();
    solutionController.clear();
    categoryState.clear();
    setState(() {
      file = null;
      isSubmitted = false;
      //Gives to postId a new Unique uid everytime a post is uploaded
      postId = Uuid().v4();
      Navigator.pop(context);
    });
  }

  List<bool> categoryState = [false, false, false, false];

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: "Create Post It"),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new RaisedButton(
                          child: new Text('TEAM'),
                          textColor: categoryState[0]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: categoryState[0]
                              ? Color(0XFF00d1ff)
                              : Colors.grey.shade50,
                          onPressed: () {
                            setState(() {
                              categoryState[0] = !categoryState[0];
                              print(categoryState[0]);
                            });
                          }),
                      SizedBox(
                        width: 10.0,
                      ),
                      new RaisedButton(
                          child: new Text('PROJECT'),
                          textColor: categoryState[1]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: categoryState[1]
                              ? Color(0XFF52d681)
                              : Colors.grey.shade50,
                          onPressed: () {
                            setState(() {
                              categoryState[1] = !categoryState[1];
                              print(categoryState[1]);
                            });
                          }),
                      SizedBox(
                        width: 10.0,
                      ),
                      new RaisedButton(
                          child: new Text('IDEA'),
                          textColor: categoryState[2]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: categoryState[2]
                              ? Color(0XFFffc300)
                              : Colors.grey.shade50,
                          onPressed: () {
                            setState(() {
                              categoryState[2] = !categoryState[2];
                              print(categoryState[2]);
                            });
                          }),
                      SizedBox(
                        width: 10.0,
                      ),
                      new RaisedButton(
                          child: new Text('IMPROVE'),
                          textColor: categoryState[3]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: categoryState[3]
                              ? Color(0XFFa40a3c)
                              : Colors.grey.shade50,
                          onPressed: () {
                            setState(() {
                              categoryState[3] = !categoryState[3];
                              print(categoryState[3]);
                            });
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                child: Container(
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title your post",
                        labelStyle:
                            TextStyle(fontSize: 15, fontFamily: "PT-Sans")),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                child: Container(
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Describe it",
                        labelStyle:
                            TextStyle(fontSize: 15, fontFamily: "PT-Sans")),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                child: TextFormField(
                  minLines: 2,
                  maxLines: 4,
                  controller: solutionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Suggest solution",
                      labelStyle:
                          TextStyle(fontSize: 15, fontFamily: "PT-Sans")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 30),
                child: GestureDetector(
                  onTap: () => selectImage(context),
                  child: file == null
                      ? Container(
                          height: 250.0,
                          //width: 400.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(width: 0.80, color: Colors.grey.shade100),
                            gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).buttonColor,
                                  Theme.of(context).backgroundColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10.0),
                              Text(
                                "Add image",
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "CabinSketch"),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                CupertinoIcons.photo_camera,
                                color: Theme.of(context).backgroundColor,
                                size: 90.0,
                              )
                            ],
                          ),
                        )
                      : buildUploadImage(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 120.0, right: 120, top: 30, bottom: 40.0),
                child: GestureDetector(
                  onTap: isSubmitted ? null : () => submitPost(),
                  child: Container(
                    height: 45,
                    width: 100,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      onPressed: isSubmitted ? null : () => submitPost(),
                      color: Theme.of(context).buttonColor,
                      child: Text(
                        "Post",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "PT-Sans",
                            color: Colors.yellow.shade50),
                      ),
                    ),
                  ),
                ),
              ),
              isSubmitted ? linearProgress() : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
