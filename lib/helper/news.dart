import 'dart:convert';

import 'package:FlutterNews/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=d6c0b757c2d8409b9cbd50910e6d9170";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            articleUrl: element['url'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
          );
          news.add(articleModel);

        }
      });
    }
  }
}

class CatrgoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?category=$category&country=in&category=business&apiKey=d6c0b757c2d8409b9cbd50910e6d9170";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            articleUrl: element['url'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
          );
          news.add(articleModel);

        }
      });
    }
  }
}
