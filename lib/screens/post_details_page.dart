import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../models/comment.dart';
import '../providers/comment_provider.dart';
import '../widgets/comment_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (post.imageUrl.isNotEmpty)
                Image.network(post.imageUrl, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(
                post.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Published: ${post.createdDate}'),
              const SizedBox(height: 20),
              Text(
                post.summary,
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    commentProvider.addComment(post.id, value);
                  }
                },
              ),
              const SizedBox(height: 10),
              ...commentProvider.getComments(post.id).map(
                    (comment) => CommentWidget(postId: post.id, comment: comment),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
