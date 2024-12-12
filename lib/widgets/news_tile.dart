
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

// profile_settings_page.dart
import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => ProfileSettingsPageState();
}

class ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final TextEditingController preferencesController = TextEditingController();
  final List<String> preferences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Your Preferences',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: preferencesController,
              decoration: const InputDecoration(
                labelText: 'Add Preference',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  preferences.add(preferencesController.text);
                  preferencesController.clear();
                });
              },
              child: const Text('Save Preference'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: preferences.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(preferences[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          preferences.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// widgets/news_tile.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/bookmark_provider.dart';
import '../screens/post_details_page.dart';

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
        trailing: IconButton(
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

// utils/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class ApiService {
  static const String _apiKey = "b2e27113-1394-4124-9d98-76620bcd92bc";

  static Future<List<Post>> fetchPosts(String query) async {
    final url =
        'https://content.guardianapis.com/search?q=$query&api-key=$_apiKey&show-fields=trailText,thumbnail';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['response']['results'] as List<dynamic>;
      return results.map((json) => Post.fromGuardianJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}