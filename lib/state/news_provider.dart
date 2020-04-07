import 'package:flutter/cupertino.dart';
import 'package:newsapp/repositories/news.dart';
import 'package:newsapp/models/article_model.dart';

class NewsState extends ChangeNotifier {
  bool isLoading = true;
  bool _isSearch = false;
  List<Article> _articles = [];
  String _category = 'general';
  int _page = 1;
  News _news = News();

  NewsState() {
    getTopArticles('general', null);
  }

  List<Article> get articlesList => _articles;

  String get selectedCategory => _category;

  int get currentPage => _page;

  bool get isSearch => _isSearch;

  setSearchTo(bool value) {
    _isSearch = value;
    notifyListeners();
  }

  set loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  loadMoreArticles() async {
    _page++;
    this._articles = _articles + await _news.getNews(_category, _page, null);
    notifyListeners();
  }

  getTopArticles(String category, String keywords) async {
    print('GET TOP ARTICLES');
    _page = 1;
    _category = category;
    _articles.clear();
    loading = true;
    this._articles =
        _articles + await _news.getNews(_category, _page, keywords);
    loading = false;
  }

  refreshList() {
    getTopArticles(_category, null);
  }
}
