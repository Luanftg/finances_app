import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';

abstract class FinanceMovimentRepository {
  Future<bool> save(FinanceMovimentModel financeMovimentModel);
  Future<List<FinanceMovimentModel>> findAll();
  Future<List<FinanceMovimentModel>> findPerMonth(int month);
}
