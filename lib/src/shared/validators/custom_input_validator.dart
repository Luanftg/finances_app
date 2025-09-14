class CustomInputValidator {
  static String? validarNome(String? value) {
    String patttern = r"(^[a-zA-ZÀ-ÿ'\s]+$)";
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  static String? validarCelular(String? value) {
    // String patttern = r'(^[0-9]*$)';
    String patttern = r"\d{2}-\d{5}-\d{4}";
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Informe o celular";
    } else if (value.length != 13) {
      return "O número informado deve ter 11 dígitos.";
    } else if (!regExp.hasMatch(value)) {
      return "O número do celular so deve conter dígitos";
    }
    return null;
  }

  static String? validarEmail(String? value) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? '');

    if (value == null || value.isEmpty) {
      return "Informe o Email";
    } else if (!emailValid) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  static String? vericaPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha';
    } else if (value.length < 6) {
      return 'A senha deve conter ao menos 6 dígitos';
    }
    return null;
  }

  static String? vericaConfirmacaoDePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha';
    } else if (value.length < 6) {
      return 'Senha inválida';
      // } else if (value != RegisterPage.passwordController.text) {
      // return 'As senhas não conferem';
    }
    return null;
  }

  static String? validaNumeroDoCartao(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return 'Informe o número do cartão';
    } else if (!regExp.hasMatch(value)) {
      return "O número do cartão so deve conter dígitos numéricos";
    } else if (value.length != 16) {
      return 'Numero do cartão deve possuir 16 digitos';
    }
    return null;
  }

  static String? validaDataDeValidade(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);

    if (value == null || value.isEmpty) {
      return 'Informe a data de validade do cartão';
    } else if (!regExp.hasMatch(value)) {
      return "A data de validade so deve conter dígitos numéricos";
    } else if (value.length != 4) {
      return 'Informe 2 dígitos referentes ao mês e mais 2 dígitos referen ao ano';
    }

    var ano = int.parse(value.substring(2));
    var mes = int.parse(value.substring(0 - 1));

    if (ano < DateTime.now().year) {
      return 'Data de validade expirada';
    }
    if (mes < DateTime.now().month) {
      return 'Data de validade expirada';
    }
    return null;
  }

  static String? validaCcv(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return 'Informe o código de segurança do cartão';
    } else if (!regExp.hasMatch(value)) {
      return "O código de segurança só deve conter dígitos numéricos";
    } else if (value.length > 4) {
      return 'O código de segurança deve conter no máximo 4 digitos';
    }
    return null;
  }
}
