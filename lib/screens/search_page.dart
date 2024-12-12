import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import '../models/post.dart';
import '../widgets/news_tile.dart';
 
class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Articles')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search articles...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(query: query),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultsPage extends StatelessWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Results')),
      body: FutureBuilder<List<Post>>(
        future: ApiService.fetchPosts(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found.'));
          } else {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final post = results[index];
                return NewsTile(post: post);
              },
            );
          }
        },
      ),
    );
  }
}
