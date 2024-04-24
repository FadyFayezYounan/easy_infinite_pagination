import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostGridWidget extends StatelessWidget {
  const PostGridWidget({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                post.id.toString(),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                post.title,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                post.body,
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.black54,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
