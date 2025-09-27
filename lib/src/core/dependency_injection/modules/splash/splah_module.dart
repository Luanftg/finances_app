import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';
import 'package:finances_app/src/core/dependency_injection/modules/base_module.dart';
import 'package:finances_app/src/features/splash/splash_view_model.dart';

class SplahModule implements BaseModule {
  @override
  void register(DependencyInjector injector) {
    injector.registerSingleton(
      () => SplashViewModel(
        httpClient: injector.get(),
        localStorage: injector.get(),
      ),
    );
  }
}
