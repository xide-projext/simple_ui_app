import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening full article URL

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  final Map<int, List<String>> _replies = {}; // Map to store replies for each comment
  final List<String> _comments = [];

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(_commentController.text);
        _commentController.clear();
      });
    }
  }

  void _addReply(int index, String reply) {
    if (reply.isNotEmpty) {
      setState(() {
        _replies[index] = (_replies[index] ?? [])..add(reply);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.post.imageUrl.isNotEmpty)
                Image.network(widget.post.imageUrl, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(
                widget.post.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Published: ${widget.post.createdDate}'),
              const SizedBox(height: 20),
              Text(
                widget.post.summary,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final url = widget.post.url;
                  if (await canLaunch(url)) {
                    await launch(url); // Open the full article URL in a browser
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text('Read Full Article'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Comments:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(_comments[index]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...?_replies[index]?.map((reply) => Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text('Reply: $reply'),
                                )),
                            const SizedBox(height: 10),
                            TextField(
                              onSubmitted: (reply) {
                                _addReply(index, reply);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Add a reply',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Add a comment',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addComment,
                child: const Text('Post Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
