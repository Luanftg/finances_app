import 'package:finances_app/src/core/extensions/datetime_extension.dart';
import 'package:finances_app/src/core/extensions/double_extension.dart';
import 'package:finances_app/src/core/widgets/finance_moviment_card_base_widget.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';
import 'package:flutter/material.dart';

class FinancesCardStatic extends StatelessWidget {
  const FinancesCardStatic({
    super.key,
    this.color,
    required this.entry,
  });

  final Color? color;
  final FinanceMovimentModel entry;

  @override
  Widget build(BuildContext context) {
    return FinancesMovimentCardBaseWidget(
      color: color,
      isExpenseBuilder: (_) => Text(
        entry.isExpense ? "Despesa" : "Receita",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      cardColorBuilder: (_) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: entry.categoryModel.color,
        ),
      ),
      dateWidget: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'Data: '),
            TextSpan(text: entry.data.onlyDate),
          ],
        ),
      ),
      descriptionWidget: Text(
        entry.description ?? '',
        textAlign: TextAlign.center,
      ),
      categoryWidget: Text(
        entry.categoryModel.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      payment: entry.value.toStringCurrency,
      valueWidget: const Offstage(),
    );
  }
}
