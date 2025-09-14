import 'package:flutter/material.dart';

import '../design.dart';
import '../styles/app_styles.dart';
import '../styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = UnderlineInputBorder(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(4), topRight: Radius.circular(4)),
    borderSide: BorderSide(color: AppCustomColors.i.primary, width: 2),
  );

  static final theme = ThemeData(
    canvasColor: AppCustomColors.i.gray900,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppCustomColors.i.primary,
      primary: AppCustomColors.i.primary,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          surfaceTintColor: WidgetStatePropertyAll(AppCustomColors.i.white),
          backgroundColor: WidgetStatePropertyAll(AppCustomColors.i.gray300),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(),
          ),
        ),
        textStyle: TextStyles.i.textRegular.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: AppCustomColors.i.gray500,
        )),
    listTileTheme: const ListTileThemeData(
      style: ListTileStyle.list,
    ),
    iconTheme: IconThemeData(color: AppCustomColors.i.gray50),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.i.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: _defaultInputBorder.copyWith(
        borderSide: BorderSide(
          color: AppCustomColors.i.red,
        ),
      ),
      errorStyle: TextStyles.i.textLabel.copyWith(color: AppCustomColors.i.red),
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: BorderSide(
          color: AppCustomColors.i.red,
        ),
      ),
      counterStyle:
          TextStyles.i.textBold.copyWith(color: AppCustomColors.i.white),
      labelStyle:
          TextStyles.i.textRegular.copyWith(color: AppCustomColors.i.gray500),
      iconColor: AppCustomColors.i.gray50,
      suffixIconColor: AppCustomColors.i.gray50,
      fillColor: AppCustomColors.i.gray900,
      floatingLabelStyle:
          WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        final Color color;
        if (states.contains(WidgetState.error)) {
          color = AppCustomColors.i.red;
        } else if (states.contains(WidgetState.focused)) {
          color = AppCustomColors.i.primary;
        } else {
          color = AppCustomColors.i.gray500;
        }

        return TextStyles.i.textLabel.copyWith(
          color: color,
        );
      }),
      filled: true,
      isDense: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder.copyWith(
        borderSide: BorderSide(color: AppCustomColors.i.primary),
      ),
    ),
    scaffoldBackgroundColor: AppCustomColors.i.black,
    appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: AppCustomColors.i.black,
        elevation: 0,
        titleTextStyle: TextStyles.i.header,
        iconTheme: IconThemeData(color: AppCustomColors.i.white),
        toolbarHeight: 82),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppCustomColors.i.black),
        textStyle: WidgetStatePropertyAll(
            TextStyles.i.header2.copyWith(color: AppCustomColors.i.white)),
      ),
    ),
    primaryColor: AppCustomColors.i.primary,
  );
}
