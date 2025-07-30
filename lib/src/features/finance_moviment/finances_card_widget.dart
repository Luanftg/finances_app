import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FinancesCardWidget extends StatelessWidget {
  const FinancesCardWidget({
    super.key,
    this.color,
    required this.isExpense,
    required this.cardColor,
    required this.dataController,
    required this.categoryController,
    required this.payment,
    required this.valueController,
    required this.descriptionController,
  });

  final Color? color;
  final ValueListenable<bool> isExpense;
  final ValueListenable<Color?> cardColor;
  final TextEditingController dataController;
  final TextEditingController categoryController;
  final String payment;
  final TextEditingController valueController;
  final TextEditingController descriptionController;

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: isExpense,
                  builder: (context, value, child) {
                    return Text(
                      value ? 'Despesa' : 'Receita',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                    controller: dataController,
                    readOnly: true,
                  ),
                )
              ],
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(border: InputBorder.none),
              controller: descriptionController,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: cardColor,
                    builder: (context, value, child) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: value,
                        ),
                      );
                    }),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        controller: categoryController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        readOnly: true,
                      ),
                      Text(
                        payment,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    controller: valueController,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
