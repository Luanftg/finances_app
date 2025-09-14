import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.splashViewModel});
  final SplashViewModel splashViewModel;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    widget.splashViewModel.startApp.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: widget.splashViewModel,
          builder: (context, child) {
            final startAppCommand = widget.splashViewModel.startApp;
            if (startAppCommand.completed &&
                startAppCommand.result is Sucess<NavigateTo>) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  startAppCommand.result?.asSucess.value.name ?? '/login',
                  (route) => true,
                );
              });
            }
            return Column(
              children: [
                Container(
                  width: 300,
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/app_icon_launcher.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                )
              ],
            );
          }),
    );
  }
}
