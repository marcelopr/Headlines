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
  AnimationController _slideCcontroller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    _slideCcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    offset = Tween<Offset>(begin: Offset(0.0, 7.0), end: Offset.zero).animate(
        CurvedAnimation(
            parent: _slideCcontroller, curve: Curves.fastLinearToSlowEaseIn));
  }

  @override
  Widget build(BuildContext context) {
    final newsState = Provider.of<NewsState>(context);

    if (newsState.isLoading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (!newsState.isLoading && newsState.articles.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Nenhum resultado encontrado.',
            style: TextStyle(fontFamily: 'Muli'),
          ),
        ),
      );
    } else {
      _slideCcontroller.reset();
      _slideCcontroller.forward();

      return Expanded(
        child: FadeTransition(
          opacity: _slideCcontroller,
          child: SlideTransition(
            position: offset,
            child: RefreshIndicator(
              onRefresh: () async {
                return newsState.refreshList();
              },
              child: ListView.separated(
                separatorBuilder: (_, i) => Divider(
                  height: 0.0,
                ),
                itemCount: newsState.articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final article = newsState.articles[index];
                  return index == 0
                      ? ArticleItemHeadLine(article: article)
                      : ArticleItem(article: article);
                },
              ),
            ),
          ),
        ),
      );
    }
  }
}
