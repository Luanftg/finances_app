import 'dart:developer';

import 'package:finances_app/src/core/result/result.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleLoginRepository {
  Future<Result<String>> googleAuth();
}

class GoogleSignInRepository implements GoogleLoginRepository {
  @override
  Future<Result<String>> googleAuth() async {
    try {
      final result = await GoogleSignIn.instance.authenticate();
      if (result case GoogleSignInAccount(:final authentication)
          when authentication.idToken != null) {
        return Result.sucess(result.authentication.idToken!);
      }
    } on GoogleSignInException catch (e) {
      return Result.failure(
        Exception('Google Sign In Exception: ${e.details}'),
      );
    } catch (e) {
      log(e.toString());
    }
    return Result.failure(Exception('Erro ao realizar login com google'));
  }
}
