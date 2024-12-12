import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentProvider extends ChangeNotifier {
  final Map<String, List<Comment>> _comments = {};

  List<Comment> getComments(String postId) {
    return _comments[postId] ?? [];
  }

  void addComment(String postId, String content) {
    final newComment = Comment(id: DateTime.now().toString(), content: content);
    _comments.putIfAbsent(postId, () => []).add(newComment);
    notifyListeners();
  }

  void addReply(String postId, String commentId, String content) {
    final postComments = _comments[postId];
    if (postComments == null) return;

    for (int i = 0; i < postComments.length; i++) {
      if (postComments[i].id == commentId) {
        final updatedComment = postComments[i].copyWith(
          replies: [
            ...postComments[i].replies,
            Comment(id: DateTime.now().toString(), content: content),
          ],
        );
        postComments[i] = updatedComment;
        notifyListeners();
        return;
      }
    }
  }
}
