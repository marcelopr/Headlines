import 'package:flutter/material.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel _category;

  const CategoryItem({@required category}) : _category = category;

  @override
  Widget build(BuildContext context) {
    final newsState = Provider.of<NewsState>(context);
    bool isSelected = newsState.selectedCategory == _category.categoryName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () => newsState.getTopArticles(_category.categoryName),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _category.categoryLabel,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontFamily: 'Muli',
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
