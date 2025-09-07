import 'package:flutter/material.dart';

class CategoryPercentageBar extends StatelessWidget {
  final List<CategoryData> categories;
  final double? width;
  final double height;
  final Duration duration;

  const CategoryPercentageBar({
    super.key,
    required this.categories,
    this.width,
    this.height = 24,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    final total = categories.fold<double>(0.0, (a, b) => a + b.value);

    if (total == 0) {
      return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Offstage());
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: categories.map((cat) {
          final percent = cat.value / total;

          return Expanded(
            flex: (percent * 1000).round(), // proporcional
            child: Tooltip(
              message:
                  '${cat.name}: ${cat.value.toStringAsFixed(2)} (${(percent * 100).toStringAsFixed(1)}%)',
              waitDuration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: duration,
                curve: Curves.easeInOut,
                color: cat.color,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryData {
  final String name;
  final double value;
  final Color? color;

  CategoryData({
    required this.name,
    required this.value,
    this.color,
  });
}
