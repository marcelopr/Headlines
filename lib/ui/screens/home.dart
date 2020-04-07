import 'package:flutter/material.dart';
import 'package:newsapp/state/news_provider.dart';

import 'package:newsapp/ui/dialogs/theme_dialog.dart';
import 'package:newsapp/ui/widgets/articles_list.dart';
import 'package:newsapp/ui/widgets/category_list.dart';
import 'package:newsapp/ui/widgets/home_appbar.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("BUILD HOME");
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: HomeAppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Consumer<NewsState>(
            builder: (context, newsState, child) {
              return Visibility(
                visible: !newsState.isSearch,
                child: CategoryList(height: screenHeight * 0.08),
              );
            },
          ),
          ArticlesList()
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final newsState = Provider.of<NewsState>(context);
    return newsState.isSearch
        ? AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => newsState.setSearchTo(false),
            ),
            title: Text('b'),
          )
        : AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Headlines',
                  style: TextStyle(
                    fontFamily: 'Ancient',
                    fontSize: 26.0,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Pesquisar',
                enableFeedback: false,
                onPressed: () {
                  newsState.setSearchTo(true);
                },
              ),
              PopupMenuButton<int>(
                icon: Icon(Icons.menu),
                tooltip: 'Configurações',
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Alterar Tema"),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      return showDialog(
                          context: context,
                          builder: (context) => ThemeDialog());
                  }
                },
              ),
            ],
          );
  }
}
