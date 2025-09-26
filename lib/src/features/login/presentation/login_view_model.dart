import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/login/data/google_login_repository.dart';
import 'package:finances_app/src/features/login/data/login_repository.dart';
import 'package:finances_app/src/features/login/domain/auth_input_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository;
  final GoogleLoginRepository _googleLoginRepository;

  LoginViewModel({
    required LoginRepository loginRepository,
    required GoogleLoginRepository googleLoginRepository,
  })  : _loginRepository = loginRepository,
        _googleLoginRepository = googleLoginRepository {
    authentication = Command0<Init>(_auth);
    googleAuthenticantion = Command0<Init>(_googleAuth);
  }

  late final Command0<Init> authentication;
  late final Command0<Init> googleAuthenticantion;

  AuthInputModel _authInputModel = AuthInputModel.initial();
  void setEmail(String email) =>
      _authInputModel = _authInputModel.copyWith(email: email);
  void setPassword(String password) =>
      _authInputModel = _authInputModel.copyWith(password: password);

  void validateForm() {
    notifyListeners();
  }

  bool get isFormValid => _authInputModel.isValid;

  Future<Result<Init>> _auth() async {
    final result = await _loginRepository.auth(_authInputModel);
    notifyListeners();
    return switch (result) {
      Sucess<Init>() => Result.sucess(Init()),
      Failure<Init>() => Result.failure(Exception('Erro ao realizar o login')),
      _ => Result.failure(Exception('Erro ao realizar o login')),
    };
  }

  Future<Result<Init>> _googleAuth() async {
    final result = await _googleLoginRepository.googleAuth();
    switch (result) {
      case Sucess<String>(:final value):
        final resultValidate =
            await _loginRepository.validateGoogleToken(value);

        notifyListeners();
        switch (resultValidate) {
          case Sucess():

            // final resultAuthMe = await _loginRepository.
            return Result.sucess(Init());
          case Failure(:final error):
            return Result.failure(error);
        }
        ;
      case Failure<Exception>(:final error):
        return Result.failure(error);
    }
    return Result.failure(Exception('Erro desconhecido'));
  }
}
