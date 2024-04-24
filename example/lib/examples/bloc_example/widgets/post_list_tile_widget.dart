import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        post.id.toString(),
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(
        post.title,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        post.body,
        style: const TextStyle(
          fontSize: 10.0,
          color: Colors.black54,
        ),
      ),
    );
  }
}
