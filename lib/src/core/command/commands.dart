import 'package:finances_app/src/core/result/result.dart';
import 'package:flutter/material.dart';

typedef CommandAction0<Output extends Object> = Future<Result<Output>>
    Function();

typedef CommandAction1<Output extends Object, Input extends Object>
    = Future<Result<Output>> Function(Input);

abstract class Command<Output extends Object> extends ChangeNotifier {
  /// Verifica se o command está em execução
  bool _isRunning = false;
  bool get isRunning => _isRunning;

  /// Representação do estado
  Result<Output>? _result;
  Result<Output>? get result => _result;

  bool get completed => _result is Sucess;
  bool get error => _result is Failure;

  /// Nao captura erros, repassa ao cliente.
  Future<void> _execute(CommandAction0<Output> action) async {
    // Impede execucao simultanea
    if (_isRunning) return;
    // Inicia a execucao da Action
    _isRunning = true;
    _result = null;
    notifyListeners();
    try {
      _result = await action();
    } finally {
      _isRunning = false;
      notifyListeners();
    }
  }
}

class Command0<Output extends Object> extends Command<Output> {
  final CommandAction0<Output> action;

  Command0(this.action);

  Future<void> execute() async {
    await _execute(() => action());
  }
}

class Command1<Output extends Object, Input extends Object>
    extends Command<Output> {
  final CommandAction1<Output, Input> action;

  Command1(this.action);

  Future<void> execute(Input param) async {
    await _execute(() => action(param));
  }
}
