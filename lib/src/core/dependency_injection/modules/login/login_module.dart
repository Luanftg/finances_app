import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';
import 'package:finances_app/src/core/dependency_injection/modules/base_module.dart';
import 'package:finances_app/src/features/login/data/google_login_repository.dart';
import 'package:finances_app/src/features/login/data/login_repository.dart';
import 'package:finances_app/src/features/login/presentation/login_view_model.dart';

class LoginModule implements BaseModule {
  @override
  void register(DependencyInjector injector) {
    injector.registerSingleton<LoginRepository>(
      () => RemoteLoginRepository(
        httpClient: injector.get(),
        localStorage: injector.get(),
      ),
    );

    injector.registerSingleton<GoogleLoginRepository>(
      () => GoogleSignInRepository(),
    );
    injector.registerFactory(
      () => LoginViewModel(
        loginRepository: injector.get(),
        googleLoginRepository: injector.get(),
      ),
    );
  }
}
