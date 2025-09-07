import 'dart:convert';

import 'package:finances_app/src/features/categories/category_model.dart';

class FinanceMovimentModel {
  final FinanceMovimentId id;
  final CategoryModel categoryModel;
  final double value;
  final TipoDePagamento tipoDePagamento;
  final DateTime data;
  final String? description;

  bool get isExpense => categoryModel.type == CategoryType.despesa;

  FinanceMovimentModel({
    required this.id,
    required this.categoryModel,
    required this.value,
    required this.tipoDePagamento,
    required this.data,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toMap(),
      'categoryModel': categoryModel.toMap(),
      'value': value,
      'tipoDePagamento': tipoDePagamento.toMap(),
      'data': data.millisecondsSinceEpoch,
      'description': description,
    };
  }

  factory FinanceMovimentModel.fromMap(Map<String, dynamic> map) {
    return FinanceMovimentModel(
      id: FinanceMovimentId.fromMap(map['id'] as Map<String, dynamic>),
      categoryModel:
          CategoryModel.fromMap(map['categoryModel'] as Map<String, dynamic>),
      value: map['value'] as double,
      tipoDePagamento: TipoDePagamento.fromMap(
          map['tipoDePagamento'] as Map<String, dynamic>),
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinanceMovimentModel.fromJson(String source) =>
      FinanceMovimentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FinanceMovimentId {
  final String value;
  FinanceMovimentId({required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
    };
  }

  factory FinanceMovimentId.fromMap(Map<String, dynamic> map) {
    return FinanceMovimentId(
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinanceMovimentId.fromJson(String source) =>
      FinanceMovimentId.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TipoDePagamento {
  final String name;
  TipoDePagamento({required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory TipoDePagamento.fromMap(Map<String, dynamic> map) {
    return TipoDePagamento(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoDePagamento.fromJson(String source) =>
      TipoDePagamento.fromMap(json.decode(source) as Map<String, dynamic>);
}
