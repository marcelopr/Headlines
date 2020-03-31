import 'package:flutter/cupertino.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';

class NewsState extends ChangeNotifier {
  bool isLoading = true;
  List<Article> _articles = [];
  String _category = 'general';
  News _news = News();

  NewsState() {
    _getNews();
  }

  _getNews() async {
    print('getNews for $_category');
    _articles.clear();
    loading = true;
    this._articles = await _news.getNews(_category, null);
    loading = false;
    print('getNews for $_category DONE');
  }

  List<Article> get articles {
    return _articles;
  }

  String get selectedCategory => _category;

  set loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set updateCategory(String category) {
    _category = category;
    notifyListeners();
    _getNews();
  }

  refreshList() {
    _getNews();
  }
}
