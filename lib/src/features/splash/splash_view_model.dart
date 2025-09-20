import 'dart:developer';

import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/core/services/shared_auth_service.dart';
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

      final response = await _httpClient.get('/auth', headers: {
        'Authorization':
            'Bearer ${await _localStorage.getString(LocalStorageKeys.authToken)}'
      });
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
