import 'package:flutter/cupertino.dart';
import 'package:newsapp/repositories/news.dart';
import 'package:newsapp/models/article_model.dart';

class NewsState extends ChangeNotifier {
  bool isLoading = true;
  bool _isSearch = false;
  bool _allLoaded = false;
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

  bool get isAllLoaded => _allLoaded;

  setSearchTo(bool value) {
    _isSearch = value;
    notifyListeners();
  }

  set loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set _setAllLoadedTo(bool value) {
    _allLoaded = value;
    notifyListeners();
  }

  loadMoreArticles() async {
    _page++;
    final news = await _news.getNews(_category, _page, null);
    if (news.isEmpty) {
      _setAllLoadedTo = true;
    } else {
      _articles += news;
      notifyListeners();
    }
  }

  getTopArticles(String category, String keywords) async {
    _page = 1;
    _category = category;
    _articles.clear();
    _allLoaded = false;
    loading = true;
    final news = await _news.getNews(_category, _page, keywords);
    if (news.isEmpty) {
      _setAllLoadedTo = true;
    } else {
      _articles += news;
    }
    loading = false;
  }

  refreshList() {
    getTopArticles(_category, null);
  }
}
