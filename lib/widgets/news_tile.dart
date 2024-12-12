import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/post_details_page.dart';

class NewsTile extends StatelessWidget {
  final Post post;

  const NewsTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: post.imageUrl.isNotEmpty
            ? Image.network(post.imageUrl, width: 100, fit: BoxFit.cover)
            : Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          post.summary,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsPage(post: post),
            ),
          );
        },
      ),
    );
  }
}
