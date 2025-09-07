import 'package:flutter/material.dart';

mixin DialogMessageMixin<T extends StatefulWidget> on State<T> {
  Future<void> showSucessDialog(String message) =>
      _showDialog(message: message);

  Future<void> showErrorDialog(String message) =>
      _showDialog(message: message, isError: true);

  Future<void> _showDialog({bool isError = false, required String message}) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Icon(
              isError
                  ? Icons.error_outline_outlined
                  : Icons.check_circle_outline,
              color: isError ? Colors.red : Colors.green,
            ),
            content: Center(
              child: Text(message),
            ),
          );
        },
      );
}
