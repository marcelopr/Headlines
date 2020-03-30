import 'package:newsapp/models/category_model.dart';

const String newsApiKey = 'SUA NEWS API KEY';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = List<CategoryModel>();
  categories
      .add(CategoryModel(categoryName: 'general', categoryLabel: 'Geral'));
  categories
      .add(CategoryModel(categoryName: 'business', categoryLabel: 'Negócios'));
  categories
      .add(CategoryModel(categoryName: 'sports', categoryLabel: 'Esportes'));
  categories.add(
      CategoryModel(categoryName: 'technology', categoryLabel: 'Tecnologia'));
  categories
      .add(CategoryModel(categoryName: 'science', categoryLabel: 'Ciência'));
  categories.add(
      CategoryModel(categoryName: 'entertainment', categoryLabel: 'Entret.'));
  categories.add(CategoryModel(categoryName: 'health', categoryLabel: 'Saúde'));

  return categories;
}
