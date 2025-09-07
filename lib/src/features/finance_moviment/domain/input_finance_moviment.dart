import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';

class InputFinanceMoviment {
  CategoryModel? categoryModel;
  double? value;
  TipoDePagamento? tipoDePagamento;
  DateTime? data;
  String? description;
  bool isExpense;
  bool isMonthFrequency;

  InputFinanceMoviment({
    this.categoryModel,
    this.value,
    this.tipoDePagamento,
    this.data,
    this.description,
    this.isExpense = true,
    this.isMonthFrequency = true,
  });

  InputFinanceMoviment copyWith({
    CategoryModel? categoryModel,
    double? value,
    TipoDePagamento? tipoDePagamento,
    DateTime? data,
    String? description,
    bool? isExpense,
    bool? isMonthFrequency,
  }) {
    return InputFinanceMoviment(
        categoryModel: categoryModel ?? this.categoryModel,
        value: value ?? this.value,
        tipoDePagamento: tipoDePagamento ?? this.tipoDePagamento,
        data: data ?? this.data,
        description: description ?? this.description,
        isExpense: isExpense ?? this.isExpense,
        isMonthFrequency: isMonthFrequency ?? this.isMonthFrequency);
  }
}
