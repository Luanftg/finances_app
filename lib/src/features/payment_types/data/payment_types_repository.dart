import 'dart:developer';

import 'package:finances_app/src/core/result/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PaymentTypesRepository {
  Future<Result<List<String>>> findAll();
}

class LocalPaymentRepository implements PaymentTypesRepository {
  final String key = 'payment_type_key';
  @override
  Future<Result<List<String>>> findAll() async {
    try {
      final shared = await SharedPreferences.getInstance();
      final stringList = shared.getStringList(key);
      if (stringList == null) {
        final List<String> paymentTypes = [
          'Pix',
          'Dinheiro',
          'Crédito',
          'Debito'
        ];
        await shared.setStringList(key, paymentTypes);
        return Result.failure(
          Exception('Erro ao buscar tipos de pagamento pelo SharedPreferences'),
        );
      }
      return Result.sucess(stringList);
    } catch (e) {
      log(e.toString());
      return Result.failure(
        Exception('Erro ao buscar tipos de pagamento pelo SharedPreferences'),
      );
    }
  }
}
