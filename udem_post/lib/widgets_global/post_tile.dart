import 'package:flutter/material.dart';
import 'package:udem_post/screens/post_screen.dart';
import 'package:udem_post/widgets_global//custom_image.dart';
import 'package:udem_post/models/post.dart';

class PostTile extends StatelessWidget {

  final Post post;

  PostTile(this.post);

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          postId: post.postId,
          userId: post.ownerId,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
    child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
