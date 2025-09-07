import 'package:flutter/material.dart';

class CircleCountWidget extends StatelessWidget {
  const CircleCountWidget(
      {super.key, required this.value, this.radius = 12, this.color});
  final int value;
  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color ?? Colors.grey,
      radius: radius,
      child: Text(
        '$value',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
