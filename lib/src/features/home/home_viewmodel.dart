import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/domain/domain.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/finance_moviment/data/finance_moviment_repository.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_list_model.dart';
import 'package:finances_app/src/shared/stores/keys/local_storage_keys.dart';
import 'package:finances_app/src/shared/stores/local_storage/local_storage.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final FinanceMovimentRepository _financeMovimentService;
  late final Command0<FinanceMovimentListModel> load;
  late final Command1<FinanceMovimentListModel, int> loadByMonth;

  ClientEntity? _clientEntity;
  ClientEntity? get clientEntity => _clientEntity;

  HomeViewModel({
    required FinanceMovimentRepository financeMovimentService,
    required LocalStorage localStorage,
  }) : _financeMovimentService = financeMovimentService {
    localStorage.getString(LocalStorageKeys.sessionUer).then(
          (value) => _clientEntity =
              value != null ? ClientEntity.fromJson(value) : null,
        );
    notifyListeners();
    load = Command0<FinanceMovimentListModel>(_loadCommand);
    loadByMonth = Command1<FinanceMovimentListModel, int>(_loadByMonthCommand)
      ..execute(_actualMonth);
  }

  int _actualMonth = DateTime.now().month;
  int get actualMonth => _actualMonth;

  void addMonth() {
    _actualMonth = _actualMonth + 1;
    loadByMonth.execute(_actualMonth);
    notifyListeners();
  }

  void substractMonth() {
    _actualMonth = _actualMonth - 1;
    loadByMonth.execute(_actualMonth);
    notifyListeners();
  }

  Future<Result<FinanceMovimentListModel>> _loadCommand() async {
    final moviments = await _financeMovimentService.findAll();
    notifyListeners();
    return Result.sucess(FinanceMovimentListModel(moviments: moviments));
  }

  Future<Result<FinanceMovimentListModel>> _loadByMonthCommand(
      int month) async {
    final moviments = await _financeMovimentService.findPerMonth(month);
    notifyListeners();
    return Result.sucess(FinanceMovimentListModel(moviments: moviments));
  }

  Future<void> loadByMonthCommand() async =>
      await loadByMonth.execute(_actualMonth);
}
