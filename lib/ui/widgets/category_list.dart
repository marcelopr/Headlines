import 'package:flutter/material.dart';
import 'package:newsapp/helper/constants.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:newsapp/ui/widgets/category_item.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';

class CategoryList extends StatelessWidget {
  final double _height;
  const CategoryList({@required height}) : _height = height;

  @override
  Widget build(BuildContext context) {
    final _categories = getCategories();
    return Consumer<NewsState>(
      builder: (context, newsState, _) {
        return Container(
          height: _height,
          child: ListView.builder(
            itemCount: _categories.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CategoryItem(category: _categories[index]);
            },
          ),
        );
      },
    );
  }
}
