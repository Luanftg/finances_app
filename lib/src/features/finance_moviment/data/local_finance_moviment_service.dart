import 'dart:convert';
import 'dart:developer';

import 'package:finances_app/src/features/finance_moviment/data/finance_moviment_service.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFinanceMovimentService implements FinanceMovimentService {
  final String _financeMovimentKey = 'finance_moviments_key';

  @override
  Future<List<FinanceMovimentModel>> findAll() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final fromShared = sharedPreferences.getStringList(_financeMovimentKey);
      if (fromShared != null) {
        final decodedList =
            fromShared.map((e) => FinanceMovimentModel.fromJson(e)).toList();
        return decodedList;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  @override
  Future<void> save(FinanceMovimentModel financeMovimentModel) async {
    try {
      final List<FinanceMovimentModel> savedList = List.from(await findAll());
      savedList.add(financeMovimentModel);
      final encodedList = savedList.map((e) => jsonEncode(e.toMap())).toList();
      final sharedPreferences = await SharedPreferences.getInstance();

      await sharedPreferences.setStringList(_financeMovimentKey, encodedList);
      return;
    } catch (e) {
      log(e.toString());
    }
  }
}
