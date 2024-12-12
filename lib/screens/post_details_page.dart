import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/post.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  if (await canLaunch(post.url)) {
                    await launch(post.url);
                  } else {
                    throw 'Could not launch ${post.url}';
                  }
                },
                child: const Text('Read Full Article'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  final comment = post.comments[index];
                  return ListTile(
                    title: Text(comment.username),
                    subtitle: Text(comment.content),
                  );
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Add a comment'),
                onSubmitted: (text) {
                  // Logic to add a new comment
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

