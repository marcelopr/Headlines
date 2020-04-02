import 'package:flutter/cupertino.dart';
import 'package:newsapp/repositories/news.dart';
import 'package:newsapp/models/article_model.dart';

class NewsState extends ChangeNotifier {
  bool isLoading = true;
  List<Article> _articles = [];
  String _category = 'general';
  int _page = 1;
  News _news = News();

  NewsState() {
    getTopArticles('general');
  }

  List<Article> get articlesList => _articles;

  String get selectedCategory => _category;

  int get currentPage => _page;

  set loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  loadMoreArticles() async {
    _page++;
    this._articles = _articles + await _news.getNews(_category, _page, null);
    notifyListeners();
  }

  getTopArticles(String category) async {
    _page = 1;
    _category = category;
    _articles.clear();
    loading = true;
    this._articles = _articles + await _news.getNews(_category, _page, null);
    loading = false;
  }

  refreshList() {
    getTopArticles(_category);
  }
}
