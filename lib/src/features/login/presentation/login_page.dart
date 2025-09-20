import 'package:awesome_icons/awesome_icons.dart';
import 'package:finances_app/src/core/mixins/dialog_message_mixin.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/login/presentation/login_view_model.dart';
import 'package:finances_app/src/shared/validators/custom_input_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.loginViewModel});

  final LoginViewModel loginViewModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with DialogMessageMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: widget.loginViewModel,
          builder: (context, child) {
            final comandAuth = widget.loginViewModel.authentication;
            final commandGoogle = widget.loginViewModel.googleAuthenticantion;
            if (comandAuth.isRunning || commandGoogle.isRunning) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if ((comandAuth.error || commandGoogle.error) &&
                    (comandAuth.result is Failure) ||
                (commandGoogle.result is Failure)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showErrorDialog(
                    comandAuth.result?.asFailure.error.toString() ?? '');
              });
            }
            if ((comandAuth.completed || commandGoogle.completed) &&
                    (comandAuth.result is Sucess) ||
                (commandGoogle.result is Sucess)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (_) => false);
              });
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  onChanged: () {
                    if (_key.currentState?.validate() ?? false) {
                      widget.loginViewModel.validateForm();
                    }
                  },
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 300, maxWidth: 300),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/app_icon_launcher.png'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Realize o login para acessar sua conta'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(),
                        ),
                        validator: CustomInputValidator.validarEmail,
                        onChanged: widget.loginViewModel.setEmail,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          label: Text('Senha'),
                          border: OutlineInputBorder(),
                        ),
                        validator: CustomInputValidator.vericaPassword,
                        onChanged: widget.loginViewModel.setPassword,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: !widget.loginViewModel.isFormValid
                              ? null
                              : () => widget.loginViewModel.authentication
                                  .execute(),
                          child: Text('Entrar'),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Não tem conta ?'),
                          TextButton(
                            onPressed: () {},
                            child: Text('Criar agora!'),
                          ),
                        ],
                      ),
                      Text(
                        'Ou',
                        textAlign: TextAlign.center,
                      ),
                      ListenableBuilder(
                          listenable:
                              widget.loginViewModel.googleAuthenticantion,
                          builder: (context, child) {
                            return widget.loginViewModel.googleAuthenticantion
                                    .isRunning
                                ? CircularProgressIndicator()
                                : SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: widget.loginViewModel
                                          .googleAuthenticantion.execute,
                                      child: Row(
                                        spacing: 16,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.google),
                                          Text('Acessar com o Google')
                                        ],
                                      ),
                                    ),
                                  );
                          })
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
