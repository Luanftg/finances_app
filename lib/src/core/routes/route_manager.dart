import 'dart:developer';
import 'dart:io';

import 'package:finances_app/src/core/dependency_injection/app_injector.dart';

import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_page.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_viewmodel.dart';
import 'package:finances_app/src/features/home/home_page.dart';
import 'package:finances_app/src/features/home/home_viewmodel.dart';

import 'package:finances_app/src/features/login/presentation/login_page.dart';
import 'package:finances_app/src/features/login/presentation/login_view_model.dart';
import 'package:finances_app/src/features/splash/splash_page.dart';
import 'package:finances_app/src/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger_package/logger_package.dart';
import 'package:path_provider/path_provider.dart';

class RouteManager {
  static late final LogRepository _logRepository;
  static init() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/backupRequests');
    log('Arquivo de BACKUP salvo em: ${backupDir.path}');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    final String path = '${backupDir.path}/requests_backup.json';
    _logRepository = FileLogRepository(path);
  }

  static Map<String, WidgetBuilder> get routes => {
        '/': (context) => SplashPage(
            splashViewModel: AppInjector.instance.get<SplashViewModel>()),
        'login': (context) => LoginPage(
            loginViewModel: AppInjector.instance.get<LoginViewModel>()),
        'home': (context) =>
            HomePage(homeViewModel: AppInjector.instance.get<HomeViewModel>()),
        'add_finance': (context) => AddFinanceMovimentPage(
            viewmodel: AppInjector.instance.get<AddFinanceMovimentViewmodel>()),
        'log_screen': (context) => LogScreen(repository: _logRepository),
      };
}
