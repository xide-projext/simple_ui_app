class Comment {
  final String text;
  final List<Comment> replies;

  Comment({required this.text, this.replies = const []});
}
