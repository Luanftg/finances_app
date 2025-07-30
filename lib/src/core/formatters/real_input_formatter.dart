import 'package:flutter/services.dart';

class RealInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove tudo que não é dígito
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Se estiver vazio, volta R$ 0,00
    if (numericString.isEmpty) {
      return TextEditingValue(
        text: 'R\$ 0,00',
        selection: TextSelection.collapsed(offset: 8),
      );
    }

    // Converte para centavos e formata manualmente
    double value = double.parse(numericString) / 100;

    // Separa parte inteira e decimal
    List<String> parts = value.toStringAsFixed(2).split('.');
    String reais = parts[0];
    String centavos = parts[1];

    // Adiciona pontos nos milhares
    String reaisFormatado = '';
    for (int i = 0; i < reais.length; i++) {
      int pos = reais.length - i;
      reaisFormatado = reais[pos - 1] + reaisFormatado;
      if (i % 3 == 2 && pos > 1) {
        reaisFormatado = '.$reaisFormatado';
      }
    }

    String result = 'R\$ $reaisFormatado,$centavos';

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}
