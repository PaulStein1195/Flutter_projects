import 'dart:io';
import 'package:bomfire_v3/controllers/themeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late String _image, _title, _description; //_postId = Uuid().v4;
  bool isUploadingPost = false;
  late File file;
  late double _width;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  final ThemeController themeController = Get.put(ThemeController());
  bool themeVal = true;

  //get the userID from back, as if we get here it causes error
  String userID = Get.arguments;
  final ThemeController themeCont = Get.put(ThemeController());

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            Firestore.instance.collection('users').document(userID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "Something went wrong",
              style: TextStyle(
                color: themeCont.theme.value == "dark"
                    ? Get.theme.primaryColorLight
                    : Get.theme.primaryColorDark,
                fontSize: 17,
              ),
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //convert data to map, we can also show number here, as its in map
            Map<String, dynamic> data =
                snapshot.data as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        child: Form(
                          key: _formKey,
                          onChanged: () {
                            _formKey.currentState!.save();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add title',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                    //_submitPostButton(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                //_descriptionTextField(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                //_smartContentSpace()
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: new AlwaysStoppedAnimation<Color>(
                themeCont.theme.value == "dark"
                    ? Get.theme.primaryColorLight
                    : Get.theme.primaryColorDark,
              ),
            ),
          );
        });
  }
}
