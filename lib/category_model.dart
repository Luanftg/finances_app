import 'dart:ui';

class CategoryModel {
  final String name;
  final Color? color;
  final CategoryType type;

  CategoryModel({
    required this.name,
    this.color,
    this.type = CategoryType.despesa,
  });
}

enum CategoryType { despesa, receita }
