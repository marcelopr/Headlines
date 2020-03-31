import 'dart:convert';
import 'package:newsapp/helper/constants.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  Future<List<Article>> getNews(String category, String keyWords) async {
    List<Article> news = [];
    String url = keyWords == null
        ? 'https://newsapi.org/v2/top-headlines?pageSize=20&category=$category&country=br&apiKey=$newsApiKey'
        : 'https://newsapi.org/v2/top-headlines?q=$keyWords&pageSize=20&category=$category&country=br&apiKey=$newsApiKey';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            news.add(Article.fromJson(element));
          }
        },
      );
    }
    return news;
  }
}
