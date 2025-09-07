import 'package:finances_app/src/core/extensions/double_extension.dart';
import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:flutter/material.dart';

class FinancesCardWidget extends StatelessWidget {
  const FinancesCardWidget({
    super.key,
    required this.isExpense,
    required this.data,
    required this.category,
    required this.payment,
    required this.value,
    required this.description,
  });

  final bool isExpense;
  final String? data;
  final CategoryModel? category;
  final String? payment;
  final double? value;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: category?.color ?? Colors.grey,
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isExpense ? 'Despesa' : 'Receita',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 120, child: Text(data ?? ''))
              ],
            ),
            Text(description ?? ''),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: category?.color ?? Colors.transparent,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(category?.name ?? ''),
                      Text(
                        payment ?? '',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(width: 80, child: Text(value?.toStringCurrency ?? '')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
