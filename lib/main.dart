import 'package:flutter/material.dart';
import 'package:flutter_app_taxi/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const TaxiFareProject(),
  );
}

class TaxiFareProject extends StatefulWidget {
  const TaxiFareProject({super.key});

  @override
  State<TaxiFareProject> createState() => _TaxiFareProjectState();
}

class _TaxiFareProjectState extends State<TaxiFareProject> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
          textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme)),
    );
  }
}