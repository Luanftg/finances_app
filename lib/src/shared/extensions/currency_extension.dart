part of 'extension.dart';

extension CurrencyExtension on double {
  String get moneyFormat {
    String price = toString();
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), ',');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
      return 'R\$ ${value}0';
    }
    return 'R\$ ${price}0';
  }
}
