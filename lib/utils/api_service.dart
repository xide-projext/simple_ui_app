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
