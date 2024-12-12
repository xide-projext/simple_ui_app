// screens/comment_section.dart
import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final List<Comment> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  void _addComment(String text) {
    setState(() {
      _comments.add(Comment(text: text));
    });
    _commentController.clear();
  }

  void _addReply(Comment parent, String text) {
    setState(() {
      parent.replies.add(Comment(text: text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            hintText: 'Write a comment...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (text) {
            if (text.isNotEmpty) {
              _addComment(text);
            }
          },
        ),
        const SizedBox(height: 10),
        ..._comments.map((comment) => CommentTile(
              comment: comment,
              onReply: (replyText) => _addReply(comment, replyText),
            )),
      ],
    );
  }
}

class CommentTile extends StatelessWidget {
  final Comment comment;
  final void Function(String replyText) onReply;

  const CommentTile({super.key, required this.comment, required this.onReply});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _replyController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(comment.text),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              ...comment.replies.map((reply) => ListTile(title: Text(reply.text))),
              TextField(
                controller: _replyController,
                decoration: const InputDecoration(
                  hintText: 'Write a reply...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (replyText) {
                  if (replyText.isNotEmpty) {
                    onReply(replyText);
                    _replyController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// models/comment.dart
class Comment {
  final String text;
  final List<Comment> replies;

  Comment({required this.text, this.replies = const []});
}
