import 'package:auto_injector/auto_injector.dart';
import 'package:finances_app/src/core/dependency_injection/dependency_injector.dart';

class AutoInjectorAdapter implements DependencyInjector {
  final AutoInjector _injector;

  AutoInjectorAdapter(this._injector);

  @override
  void registerSingleton<T extends Object>(T Function() factoryFunc) {
    _injector.addSingleton<T>(factoryFunc);
  }

  @override
  void registerFactory<T extends Object>(T Function() factoryFunc) {
    _injector.add<T>(factoryFunc);
  }

  @override
  T get<T extends Object>() {
    return _injector.get<T>();
  }
}
