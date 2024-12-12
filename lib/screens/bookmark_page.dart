import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bookmark_provider.dart';
import '../models/post.dart';
import '../widgets/news_tile.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          final bookmarks = bookmarkProvider.bookmarks;

          if (bookmarks.isEmpty) {
            return const Center(
              child: Text('No bookmarks yet.'),
            );
          }

          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final post = bookmarks[index] as Post;
              return NewsTile(post: post);
            },
          );
        },
      ),
    );
  }
}
