import 'package:auto_injector/auto_injector.dart';
import 'package:finances_app/src/core/dependency_injection/adapter/auto_injector_adapter.dart';
import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';
import 'package:finances_app/src/core/dependency_injection/modules/app/app_module.dart';
import 'package:finances_app/src/core/dependency_injection/modules/base_module.dart';
import 'package:finances_app/src/core/dependency_injection/modules/finance_moviment/finance_moviment_module.dart';
import 'package:finances_app/src/core/dependency_injection/modules/home/home_module.dart';
import 'package:finances_app/src/core/dependency_injection/modules/login/login_module.dart';
import 'package:finances_app/src/core/dependency_injection/modules/splash/splah_module.dart';

class AppInjector {
  static late DependencyInjector _instance;
  static DependencyInjector get instance => _instance;

  static final List<BaseModule> _modules = [
    AppModule(),
    SplahModule(),
    LoginModule(),
    FinanceMovimentModule(),
    HomeModule(),
  ];

  static void initialize() {
    // 1. Instanciar a biblioteca concreta
    final concreteInjector = AutoInjector();

    // 2. Criar o Adapter
    _instance = AutoInjectorAdapter(concreteInjector);

    // 3. Registrar todas as dependências pelos módulos
    for (final module in _modules) {
      module.register(_instance);
    }

    if (_instance is AutoInjectorAdapter) {
      concreteInjector.commit();
    }
  }
}
