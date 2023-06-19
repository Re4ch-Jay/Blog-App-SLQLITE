import 'package:blog_app/models/blog_model.dart';
import 'package:flutter/material.dart';

class BlogButton extends StatelessWidget {
  const BlogButton({
    super.key,
    required this.blog,
  });

  final Blog? blog;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          blog == null ? 'Post' : 'Update',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
