// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'color': color?.value,
      'type': type.toString(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      type: CategoryType.fromString(map['type'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum CategoryType {
  despesa,
  receita;

  static CategoryType fromString(String value) {
    return switch (value) {
      'despesa' => CategoryType.despesa,
      'receita' => CategoryType.receita,
      _ => CategoryType.despesa
    };
  }
}
