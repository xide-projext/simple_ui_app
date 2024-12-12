import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/bookmark_provider.dart';
import '../screens/post_details_page.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for opening URLs

class NewsTile extends StatelessWidget {
  final Post post;

  const NewsTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: post.imageUrl.isNotEmpty
            ? Image.network(post.imageUrl, width: 100, fit: BoxFit.cover)
            : null,
        title: Text(post.title),
        subtitle: Text(post.summary, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                bookmarkProvider.bookmarks.contains(post)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () {
                bookmarkProvider.bookmarks.contains(post)
                    ? bookmarkProvider.removeBookmark(post)
                    : bookmarkProvider.addBookmark(post);
              },
            ),
            IconButton(
              icon: const Icon(Icons.open_in_browser),
              onPressed: () async {
                if (await canLaunch(post.url)) {
                  await launch(post.url); // Open the article URL in a browser
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch URL')),
                  );
                }
              },
            ),
          ],
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

