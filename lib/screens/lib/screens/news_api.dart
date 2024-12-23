import 'package:http/http.dart' as http;
import 'dart:convert';
import 'article.dart'; // Your article model class

class NewsAPI {
  final String apiKey;

  NewsAPI(this.apiKey);

  Future<List<Article>> getTopHeadlines({String country = 'us', int pageSize = 10}) async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=$country&pageSize=$pageSize&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> articlesJson = jsonResponse['articles'];
      return articlesJson.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
