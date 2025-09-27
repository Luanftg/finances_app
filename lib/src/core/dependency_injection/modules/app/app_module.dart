import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';
import 'package:finances_app/src/core/dependency_injection/modules/base_module.dart';
import 'package:finances_app/src/shared/http/dio/dio_http_client.dart';
import 'package:finances_app/src/shared/http/http.dart';
import 'package:finances_app/src/shared/stores/local_storage/local_storage.dart';
import 'package:finances_app/src/shared/stores/shared_pref_storage.dart';

class AppModule implements BaseModule {
  @override
  void register(DependencyInjector injector) {
    injector.registerSingleton<LocalStorage>(SharedPrefStorage.new);
    injector.registerSingleton<HttpClient>(DioHttpClient.new);
  }
}
