import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';
import 'package:finances_app/src/core/dependency_injection/modules/base_module.dart';
import 'package:finances_app/src/features/categories/data/category_repository.dart';
import 'package:finances_app/src/features/categories/data/local_category_repository.dart';
import 'package:finances_app/src/features/finance_moviment/data/finance_moviment_repository.dart';
import 'package:finances_app/src/features/finance_moviment/data/local_finance_moviment_repository.dart';
import 'package:finances_app/src/features/home/home_viewmodel.dart';
import 'package:finances_app/src/features/payment_types/data/payment_types_repository.dart';

class HomeModule implements BaseModule {
  @override
  void register(DependencyInjector injector) {
    injector.registerSingleton<CategoryRepository>(LocalCategoryRepository.new);
    injector
        .registerSingleton<PaymentTypesRepository>(LocalPaymentRepository.new);
    injector.registerSingleton<FinanceMovimentRepository>(
        LocalFinanceMovimentRepository.new);
    injector.registerFactory(
      () => HomeViewModel(
        financeMovimentService: injector.get(),
        localStorage: injector.get(),
      ),
    );
  }
}
