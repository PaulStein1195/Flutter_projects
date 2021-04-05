import 'package:flutter/material.dart';
import 'package:udem_post/models/post.dart';
import 'package:udem_post/screens/home.dart';
import 'package:udem_post/widgets_global//header.dart';
import 'package:udem_post/widgets_global//progress.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;


  PostScreen({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef.document(userId).collection("userPosts").document(postId).get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            appBar: header(context,isAppTitle: false, titleText: post.title),
            body: ListView(
              children: [
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
