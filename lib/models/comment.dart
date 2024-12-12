class Comment {
  final String id;
  final String content;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    this.replies = const [],
  });

  Comment copyWith({List<Comment>? replies}) {
    return Comment(
      id: id,
      content: content,
      replies: replies ?? this.replies,
    );
  }
}
