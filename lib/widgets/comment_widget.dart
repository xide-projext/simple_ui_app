import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/comment.dart';
import '../providers/comment_provider.dart';

class CommentWidget extends StatelessWidget {
  final String postId;
  final Comment comment;

  const CommentWidget({super.key, required this.postId, required this.comment});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _replyController = TextEditingController();
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(comment.content),
          subtitle: TextField(
            controller: _replyController,
            decoration: const InputDecoration(
              hintText: 'Reply...',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                commentProvider.addReply(postId, comment.id, value);
                _replyController.clear();
              }
            },
          ),
        ),
        ...comment.replies.map((reply) => Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(title: Text(reply.content)),
            )),
      ],
    );
  }
}
