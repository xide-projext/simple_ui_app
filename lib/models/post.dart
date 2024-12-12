class Post {
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String createdDate;

  Post({
    required this.title,
    required this.summary,
    required this.url,
    required this.imageUrl,
    required this.createdDate,
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
