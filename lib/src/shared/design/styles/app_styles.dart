import 'package:flutter/material.dart';

import '../design.dart';

class AppStyles {
  static AppStyles? _instance;
  AppStyles._();

  static AppStyles get i {
    return _instance ??= AppStyles._();
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppCustomColors.i.primary,
      );
}

extension AppStylesExtensions on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
