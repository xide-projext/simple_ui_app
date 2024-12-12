import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import '../models/post.dart';
import '../widgets/news_tile.dart';

class NewsCategoryPage extends StatelessWidget {
  final String category;

  const NewsCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: ApiService.fetchPosts(category),
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
              final post = posts[index];
              return NewsTile(post: post);
            },
          );
        }
      },
    );
  }
}
