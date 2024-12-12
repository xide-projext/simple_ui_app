class Post {
  final String id;
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String createdDate;

  Post({
    required this.id,
    required this.title,
    required this.summary,
    required this.url,
    required this.imageUrl,
    required this.createdDate,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      title: json['webTitle'] ?? 'No Title',
      summary: json['fields']['trailText'] ?? 'No Summary',
      url: json['webUrl'] ?? '',
      imageUrl: json['fields']['thumbnail'] ?? '',
      createdDate: json['webPublicationDate'] ?? '',
    );
  }
}
