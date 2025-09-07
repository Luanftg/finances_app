extension CurrencyExtension on num {
  String get toStringCurrency {
    final fixed = toStringAsFixed(2); // "1234.56"
    final parts = fixed.split('.'); // ["1234", "56"]

    // parte inteira com pontos a cada 3 dígitos
    final integer = parts[0];
    final buffer = StringBuffer();
    for (int i = 0; i < integer.length; i++) {
      final position = integer.length - i;
      buffer.write(integer[i]);
      if (position > 1 && position % 3 == 1) {
        buffer.write('.');
      }
    }

    return 'R\$ ${buffer.toString()},${parts[1]}';
  }
}
