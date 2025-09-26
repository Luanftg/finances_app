import 'package:finances_app/src/core/routes/route_manager.dart';
import 'package:finances_app/src/env/env.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSignIn.instance.initialize(serverClientId: Env.googleApiKey);
  await RouteManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
    );
    return MaterialApp(
      title: 'Finance App',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      ),
      routes: RouteManager.routes,
    );
  }
}
