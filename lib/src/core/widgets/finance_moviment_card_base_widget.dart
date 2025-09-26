import 'package:flutter/material.dart';

class FinancesMovimentCardBaseWidget extends StatelessWidget {
  const FinancesMovimentCardBaseWidget({
    required this.color,
    required this.isExpenseBuilder,
    required this.cardColorBuilder,
    required this.dateWidget,
    required this.descriptionWidget,
    required this.categoryWidget,
    required this.payment,
    required this.valueWidget,
  });

  final Color? color;
  final WidgetBuilder isExpenseBuilder;
  final WidgetBuilder cardColorBuilder;
  final Widget dateWidget;
  final Widget descriptionWidget;
  final Widget categoryWidget;
  final String payment;
  final Widget valueWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: color ?? Colors.grey,
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
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isExpenseBuilder(context),
                dateWidget,
              ],
            ),
            descriptionWidget,
            Row(
              children: [
                cardColorBuilder(context),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryWidget,
                      Text(payment,
                          style: const TextStyle(fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                SizedBox(width: 80, child: valueWidget),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
