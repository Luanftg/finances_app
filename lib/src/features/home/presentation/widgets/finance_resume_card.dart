import 'package:finances_app/src/core/extensions/double_extension.dart';
import 'package:finances_app/src/core/widgets/category_percentage_bar_widget.dart';
import 'package:finances_app/src/core/widgets/circle_count_widget.dart';
import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_list_model.dart';
import 'package:flutter/material.dart';

class FinanceResumeCard extends StatelessWidget {
  const FinanceResumeCard({super.key, required this.model});

  final FinanceMovimentListModel model;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: model.moviments.isEmpty
              ? Center(
                  child: const Text(
                    'Sem Registros',
                    textAlign: TextAlign.center,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 12,
                        children: [
                          Container(
                            child: CircularProgressIndicator(
                              value: model.revenuePercentage,
                              backgroundColor: Colors.red.shade700,
                              color: Colors.green.shade700,
                              strokeCap: StrokeCap.butt,
                              strokeWidth: 5,
                              strokeAlign: 2,
                            ),
                          ),
                          Text(
                            '${model.balance.toStringCurrency}',
                            style: TextStyle(
                              color: model.balance.isNegative
                                  ? Colors.red
                                  : Colors.green.shade700,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 8,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              'Total de Despesas: ${model.totoalDespesas.toStringCurrency}',
                            ),
                            CircleCountWidget(
                              value: model.quantidadeDespesas,
                              color: Colors.red.shade700,
                            )
                          ],
                        ),
                        CategoryPercentageBar(
                            width: constraint.maxWidth * 0.65,
                            height: 8,
                            categories: model.moviments
                                .where(
                                  (element) =>
                                      element.categoryModel.type ==
                                      CategoryType.despesa,
                                )
                                .map(
                                  (e) => CategoryData(
                                      name: e.categoryModel.name,
                                      value: 100,
                                      color: e.categoryModel.color),
                                )
                                .toList()),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              'Total de Receitas: ${model.totoalReceitas.toStringCurrency}',
                            ),
                            CircleCountWidget(
                              value: model.quantidadeReceitas,
                              color: Colors.green.shade700,
                            )
                          ],
                        ),
                        CategoryPercentageBar(
                            width: constraint.maxWidth * 0.65,
                            height: 8,
                            categories: model.moviments
                                .where(
                                  (element) =>
                                      element.categoryModel.type ==
                                      CategoryType.receita,
                                )
                                .map(
                                  (e) => CategoryData(
                                      name: e.categoryModel.name,
                                      value: 100,
                                      color: e.categoryModel.color),
                                )
                                .toList()),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              'Quantidade de Movimentacoes:',
                            ),
                            CircleCountWidget(
                              value: model.moviments.length,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
