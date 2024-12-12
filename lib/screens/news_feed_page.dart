import 'package:flutter/material.dart';
import '../models/post.dart';
import '../utils/api_service.dart';
import '../widgets/news_tile.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Feed')),
      body: FutureBuilder<List<Post>>(
        future: ApiService.fetchPosts('latest'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return NewsTile(post: posts[index]);
              },
            );
          }
        },
      ),
    );
  }
}
