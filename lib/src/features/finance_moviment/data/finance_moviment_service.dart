import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';

abstract class FinanceMovimentService {
  Future<void> save(FinanceMovimentModel financeMovimentModel);
  Future<List<FinanceMovimentModel>> findAll();
}
