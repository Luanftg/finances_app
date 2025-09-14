import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/login/data/login_repository.dart';
import 'package:finances_app/src/features/login/domain/auth_input_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository;

  LoginViewModel({required LoginRepository loginRepository})
      : _loginRepository = loginRepository {
    authentication = Command0<Init>(_auth);
  }

  late final Command0<Init> authentication;

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
}
