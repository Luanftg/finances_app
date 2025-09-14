import 'package:finances_app/src/features/categories/data/local_category_repository.dart';
import 'package:finances_app/src/features/finance_moviment/data/local_finance_moviment_repository.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_page.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_viewmodel.dart';
import 'package:finances_app/src/features/home/home_page.dart';
import 'package:finances_app/src/features/home/home_viewmodel.dart';
import 'package:finances_app/src/features/login/data/login_repository.dart';
import 'package:finances_app/src/features/login/presentation/login_page.dart';
import 'package:finances_app/src/features/login/presentation/login_view_model.dart';
import 'package:finances_app/src/features/payment_types/data/payment_types_repository.dart';
import 'package:finances_app/src/features/splash/splash_page.dart';
import 'package:finances_app/src/features/splash/splash_view_model.dart';
import 'package:finances_app/src/shared/http/dio/dio_http_client.dart';
import 'package:finances_app/src/shared/stores/shared_pref_storage.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Map<String, WidgetBuilder> get routes => {
        '/': (context) => SplashPage(
              splashViewModel: SplashViewModel(
                localStorage: SharedPrefStorage(),
                httpClient: DioHttpClient(),
              ),
            ),
        'login': (context) => LoginPage(
              loginViewModel: LoginViewModel(
                  loginRepository: RemoteLoginRepository(
                httpClient: DioHttpClient(),
                localStorage: SharedPrefStorage(),
              )),
            ),
        'home': (context) => HomePage(
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
      };
}
