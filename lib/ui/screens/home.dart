import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/search.dart';
import 'package:newsapp/ui/widgets/articles_list.dart';
import 'package:newsapp/ui/widgets/category_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("BUILD HOME");
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Headlines',
              style: TextStyle(fontFamily: 'Ancient', fontSize: 26.0),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          CategoryList(height: screenHeight * 0.08),
          ArticlesList()
        ],
      ),
    );
  }
}
