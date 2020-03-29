import 'package:flutter/material.dart';
import 'package:newsapp/ui/widgets/articles_list.dart';
import 'package:newsapp/ui/widgets/category_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Headlines',
              style: TextStyle(fontFamily: 'Ancient', fontSize: 26.0),
            ),
          ],
        ),
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
