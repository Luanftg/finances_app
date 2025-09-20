import 'dart:developer';

import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/login/domain/auth_input_model.dart';
import 'package:finances_app/src/shared/http/http.dart';
import 'package:finances_app/src/shared/stores/keys/local_storage_keys.dart';
import 'package:finances_app/src/shared/stores/local_storage/local_storage.dart';

abstract class LoginRepository {
  Future<Result<Init>> auth(AuthInputModel authInputModel);
  Future<Result<Init>> validateGoogleToken(String token);
}

class RemoteLoginRepository implements LoginRepository {
  final HttpClient _httpClient;
  final LocalStorage _localStorage;

  RemoteLoginRepository(
      {required HttpClient httpClient, required LocalStorage localStorage})
      : _httpClient = httpClient,
        _localStorage = localStorage;

  @override
  Future<Result<Init>> auth(AuthInputModel authInputModel) async {
    try {
      final request = HttpRequest(
          method: HttpMethods.post,
          baseUrl: 'http://10.0.2.2:8080/auth',
          body: authInputModel.toJson());
      final response = await _httpClient.send(request);
      if (response.statusCode == 200) {
        await _localStorage.saveString(
          key: LocalStorageKeys.authToken,
          value: response.body['token'],
        );
        return Result.sucess(Init());
      }
      return Result.failure(Exception('Erro ao realizar o login.'));
    } catch (e) {
      log(e.toString());
      return Result.failure(Exception('Erro ao realizar o login.'));
    }
  }

  @override
  Future<Result<Init>> validateGoogleToken(String token) async {
    try {
      final response =
          await _httpClient.get('http://10.0.2.2:8080/auth/google/$token');
      if (response.statusCode == 200) {
        await _localStorage.saveString(
          key: LocalStorageKeys.authToken,
          value: response.body['token'],
        );
        return Result.sucess(Init());
      }
    } catch (e) {
      log(e.toString());
    }
    return Result.failure(Exception('Erro ao validar o token do Google'));
  }
}
