import 'package:flutter/material.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:newsapp/ui/widgets/article_item%20headline.dart';
import 'package:newsapp/ui/widgets/article_item.dart';
import 'package:provider/provider.dart';

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsState>(builder: (context, newsState, child) {
      if (!newsState.isLoading && newsState.articles.isEmpty) {
        return Expanded(
          child: Center(
            child: Text(
              'Nenhum resultado encontrado.',
              style: TextStyle(fontFamily: 'Muli'),
            ),
          ),
        );
      } else {
        return Expanded(
          child: Visibility(
            visible: !newsState.isLoading,
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
            replacement: Center(child: CircularProgressIndicator()),
          ),
        );
      }
    });
  }
}
