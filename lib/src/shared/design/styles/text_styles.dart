import 'package:flutter/material.dart';

import '../design.dart';

class TextStyles {
  static TextStyles? _instance;
  TextStyles._();

  static TextStyles get i => _instance ??= TextStyles._();

  String get font => 'Rubik';
  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: font);

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: font);

  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: font);

  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.w700, fontFamily: font);

  TextStyle get buttonLarge => textMedium.copyWith(
        fontSize: 15,
        letterSpacing: 0.46,
        height: 26,
        color: AppCustomColors.i.black,
      );

  TextStyle get textLabel => textRegular.copyWith(
        fontWeight: FontWeight.w400,
        color: AppCustomColors.i.gray600,
        fontSize: 16,
      );

  TextStyle get textButton => textBold.copyWith(
        color: AppCustomColors.i.grayteste,
        fontSize: 16,
      );

  TextStyle get header => textMedium.copyWith(
        color: AppCustomColors.i.gray50,
        fontSize: 24,
      );
  TextStyle get header2 => textMedium.copyWith(
        color: AppCustomColors.i.white,
        fontSize: 16,
      );

  TextStyle get textBAB => textMedium.copyWith(
        color: AppCustomColors.i.gray50,
        fontSize: 10,
        letterSpacing: 0.15,
      );

  TextStyle get titleCard => textMedium.copyWith(
        color: AppCustomColors.i.gray50,
        fontSize: 32,
        letterSpacing: 0.46,
        fontWeight: FontWeight.w500,
      );
  TextStyle get userCardTitles => textMedium.copyWith(
        color: AppCustomColors.i.white,
        fontSize: 20,
      );
  TextStyle get userCardValues => textMedium.copyWith(
        color: AppCustomColors.i.gray500,
        fontSize: 18,
      );
  TextStyle get textRoboto => textLight.copyWith(
        fontFamily: 'Roboto',
        fontSize: 18,
        color: AppCustomColors.i.white,
      );
  TextStyle get textBanner => titleCard.copyWith(
        fontFamily: 'Roboto',
        fontSize: 15,
        color: AppCustomColors.i.gray50,
        fontWeight: FontWeight.w400,
      );
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
