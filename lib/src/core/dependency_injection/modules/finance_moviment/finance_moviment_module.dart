import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';
import 'package:finances_app/src/core/dependency_injection/modules/base_module.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_viewmodel.dart';

class FinanceMovimentModule implements BaseModule {
  @override
  void register(DependencyInjector injector) {
    injector.registerFactory(
      () => AddFinanceMovimentViewmodel(
        localCategoryRepository: injector.get(),
        financeMovimentRepository: injector.get(),
        paymentRepository: injector.get(),
      ),
    );
  }
}
