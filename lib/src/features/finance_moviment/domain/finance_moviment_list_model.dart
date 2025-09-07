import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';

class FinanceMovimentListModel {
  final List<FinanceMovimentModel> moviments;

  FinanceMovimentListModel({required this.moviments});

  List<FinanceMovimentModel> get despesas => moviments
      .where((e) => e.categoryModel.type == CategoryType.despesa)
      .toList();

  List<FinanceMovimentModel> get receitas => moviments
      .where((e) => e.categoryModel.type == CategoryType.receita)
      .toList();

  double get revenuePercentage =>
      totoalReceitas / (totoalDespesas + totoalReceitas);

  double get balance => totoalReceitas - totoalDespesas;
  // double get totalPorCategoriaRece => ;

  int get quantidadeReceitas => receitas.length;

  int get quantidadeDespesas => despesas.length;

  double get totoalDespesas => despesas
      .map((e) => e.value)
      .fold(0.0, (value, element) => value + element);

  double get totoalReceitas => receitas
      .map((e) => e.value)
      .fold(0.0, (value, element) => value + element);
}
