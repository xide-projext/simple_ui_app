class Comment {
  final String username;
  final String content;
  final DateTime timestamp;
  final List<Comment> replies;

  Comment({
    required this.username,
    required this.content,
    required this.timestamp,
    this.replies = const [],
  });
}

class Post {
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String createdDate;
  final List<Comment> comments;

  Post({
    required this.title,
    required this.summary,
    required this.url,
    required this.imageUrl,
    required this.createdDate,
    this.comments = const [],
  });

  factory Post.fromGuardianJson(Map<String, dynamic> json) {
    final fields = json['fields'] ?? {};
    return Post(
      title: json['webTitle'] ?? 'No Title',
      summary: fields['trailText'] ?? 'No Summary',
      url: json['webUrl'] ?? '',
      imageUrl: fields['thumbnail'] ?? '',
      createdDate: json['webPublicationDate'] ?? '',
    );
  }
}
