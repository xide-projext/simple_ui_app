import 'package:flutter/material.dart';
import '../models/post.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  PostDetailsPage({required this.post});

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
              SizedBox(height: 10),
              Text(
                post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Published: ${post.createdDate}'),
              SizedBox(height: 20),
              Text(
                post.summary,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Open the full article in browser
                },
                child: Text('Read Full Article'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

