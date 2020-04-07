import 'package:flutter/material.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:newsapp/ui/dialogs/theme_dialog.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class _HomeAppBarState extends State<HomeAppBar> {
  TextEditingController _controller = TextEditingController();
  bool _didSearch = false;

  @override
  Widget build(BuildContext context) {
    final newsState = Provider.of<NewsState>(context);

    if (newsState.isSearch) {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            _controller.text = '';
            if (_didSearch == true) {
              newsState.getTopArticles(newsState.selectedCategory, null);
            }
            newsState.setSearchTo(false);
            setState(() => _didSearch = false);
          },
        ),
        title: TextFormField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration.collapsed(hintText: 'Pesquisar'),
          autocorrect: true,
          autofocus: true,
          onFieldSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              newsState.getTopArticles('general', _controller.text.trim());
              setState(() => _didSearch = true);
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                //setState(() => _didSearch = true);
                newsState.getTopArticles('general', _controller.text.trim());
              }
            },
          )
        ],
      );
    } else {
      return AppBar(
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
            icon: Icon(Icons.more_vert),
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
                      context: context, builder: (context) => ThemeDialog());
              }
            },
          ),
        ],
      );
    }
  }
}
