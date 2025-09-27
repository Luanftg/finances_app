abstract interface class DependencyInjector {
  void registerSingleton<T extends Object>(T Function() factoryFunc);

  void registerFactory<T extends Object>(T Function() factoryFunc);

  T get<T extends Object>();
}
