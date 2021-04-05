import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


Widget cachedNetworkImage (String mediaUrl) {
  return CachedNetworkImage(
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: CircularProgressIndicator(),
    ),
    errorWidget: (context, url, err) => Icon(Icons.error),
  );
}
