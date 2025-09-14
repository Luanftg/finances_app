import 'dart:developer';

import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/shared/http/http.dart';
import 'package:finances_app/src/shared/stores/keys/local_storage_keys.dart';
import 'package:finances_app/src/shared/stores/local_storage/local_storage.dart';
import 'package:flutter/material.dart';

enum NavigateTo { login, home }

class SplashViewModel extends ChangeNotifier {
  final LocalStorage _localStorage;
  final HttpClient _httpClient;

  late final Command0<NavigateTo> startApp;

  SplashViewModel(
      {required LocalStorage localStorage, required HttpClient httpClient})
      : _localStorage = localStorage,
        _httpClient = httpClient {
    startApp = Command0(_validateLocalUser);
  }

  Future<Result<NavigateTo>> _validateLocalUser() async {
    try {
      final userStringLocal =
          await _localStorage.getString(LocalStorageKeys.authToken);
      if (userStringLocal == null) {
        notifyListeners();
        return Result.sucess(NavigateTo.login);
      }
      final request = HttpRequest(
        method: HttpMethods.get,
        baseUrl: 'http://10.0.2.2:8080/auth',
      );
      final response = await _httpClient.send(request);
      if (response.statusCode == 200) {
        notifyListeners();
        return Result.sucess(NavigateTo.home);
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return Result.sucess(NavigateTo.login);
  }
}
