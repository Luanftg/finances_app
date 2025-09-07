import 'package:finances_app/src/features/categories/data/local_category_repository.dart';
import 'package:finances_app/src/features/finance_moviment/data/local_finance_moviment_repository.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_page.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_viewmodel.dart';
import 'package:finances_app/src/features/home/home_page.dart';
import 'package:finances_app/src/features/home/home_viewmodel.dart';
import 'package:finances_app/src/features/login/login_page.dart';
import 'package:finances_app/src/features/payment_types/data/payment_types_repository.dart';
import 'package:finances_app/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Map<String, WidgetBuilder> get routes => {
        '/': (context) => HomePage(
              homeViewModel: HomeViewModel(
                financeMovimentService: LocalFinanceMovimentRepository(),
              ),
            ),
        'add_finance': (context) => AddFinanceMovimentPage(
              viewmodel: AddFinanceMovimentViewmodel(
                localCategoryRepository: LocalCategoryRepository(),
                financeMovimentRepository: LocalFinanceMovimentRepository(),
                paymentRepository: LocalPaymentRepository(),
              ),
            ),
        'splash': (context) => SplashPage(),
        'login': (context) => LoginPage()
      };
}
