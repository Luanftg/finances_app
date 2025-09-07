import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('should test Commands', () {
    test('Should test Command execution cycle returning [Sucess]', () async {
      final command = Command0<String>(getResultSucess);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.result, isNull);

      await command.execute();

      expect(command.completed, true);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result?.asSucess.value, 'Sucess.');
    });

    test('Should test Command execution cycle returning [Failure]', () async {
      final command = Command0<String>(getResultFailure);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.result, isNull);

      await command.execute();

      expect(command.error, true);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result?.asFailure.error, isA<Exception>());
    });

    test('Should test Command1 execution cycle returning [Sucess]', () async {
      final command = Command1<String, String>(getResultSucess1);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.result, isNull);

      await command.execute('INPUT');

      expect(command.completed, true);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result?.asSucess.value, contains('INPUT'));
    });

    test('Should test Command1 execution cycle returning [Failure]', () async {
      final command = Command1<String, String>(getResultFailure1);

      expect(command.completed, false);
      expect(command.isRunning, false);
      expect(command.result, isNull);

      await command.execute('INPUT');

      expect(command.error, true);
      expect(command.isRunning, false);
      expect(command.result, isNotNull);
      expect(command.result?.asFailure.error, isA<Exception>());
    });
  });
}

Future<Result<String>> getResultSucess() async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.sucess('Sucess.');
}

Future<Result<String>> getResultFailure() async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.failure(Exception('Failure'));
}

Future<Result<String>> getResultSucess1(String param) async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.sucess('Return with param: $param');
}

Future<Result<String>> getResultFailure1(String param) async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.failure(Exception('Failure with param: $param'));
}
