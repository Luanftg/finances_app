import 'package:flutter/material.dart';

class MonthHeaderWidget extends StatelessWidget {
  const MonthHeaderWidget(
      {super.key,
      required this.actualMonth,
      required this.onSubstractMonth,
      required this.onAddMonth});
  final String actualMonth;
  final VoidCallback onSubstractMonth;
  final VoidCallback onAddMonth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: onSubstractMonth,
          ),
          Text(actualMonth),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: onAddMonth,
          ),
        ],
      ),
    );
  }
}
