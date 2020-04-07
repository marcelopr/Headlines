import 'package:flutter/material.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:newsapp/ui/widgets/article_item%20headline.dart';
import 'package:newsapp/ui/widgets/article_item.dart';
import 'package:provider/provider.dart';

class ArticlesList extends StatefulWidget {
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  AnimationController _slideCcontroller;
  Animation<Offset> _offset;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _slideCcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _offset = Tween<Offset>(begin: Offset(0.0, 7.0), end: Offset.zero).animate(
        CurvedAnimation(
            parent: _slideCcontroller, curve: Curves.fastLinearToSlowEaseIn));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsState>(
      builder: (context, newsState, child) {
        ///Reiniciar animação quando page for 1, e para-lá se n for.
        if (newsState.currentPage == 1 && !newsState.isSearch) {
          _slideCcontroller.reset();
          _slideCcontroller.forward();
        } else {
          _slideCcontroller.stop();
        }

        return Expanded(
          child: Visibility(
            visible: !newsState.isLoading,
            replacement: Center(child: CircularProgressIndicator()),
            child: _buildListResult(newsState, context),
          ),
        );
      },
    );
  }

  Widget _buildListResult(NewsState newsState, BuildContext context) {
    return Visibility(
      visible: newsState.articlesList.isNotEmpty,
      replacement: Center(
        child: Text(
          'Nenhum resultado encontrado.',
          style: TextStyle(fontFamily: 'Muli'),
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: FadeTransition(
              opacity: _slideCcontroller,
              child: SlideTransition(
                position: _offset,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (_loadingMore == false && !newsState.isAllLoaded)
                      _onScrollNotification(notification, newsState);
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return newsState.refreshList();
                    },
                    child: ListView.separated(
                      separatorBuilder: (_, i) => Divider(
                        height: 0.0,
                      ),
                      itemCount: newsState.articlesList.length,
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final article = newsState.articlesList[index];

                        return index == 0
                            ? ArticleItemHeadLine(article: article)
                            : ArticleItem(article: article);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_loadingMore) ...[LinearProgressIndicator()]
        ],
      ),
    );
  }

  _onScrollNotification(
      ScrollNotification notification, NewsState newsState) async {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      setState(() => _loadingMore = true);
      await newsState.loadMoreArticles();
      setState(() => _loadingMore = false);
    }
  }
}
