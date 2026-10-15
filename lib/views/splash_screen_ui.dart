import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_taxi/views/taxi_fare_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // หน่วงหน้าจอ 3 วินาที แล้วเปลี่ยน HomeUI แบบย้อนกลับไม่ได้
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TaxiFareUI(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 251, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/taxi.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 25),
            Text(
              'Taxi Fare Calculator',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.030,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5BB7F5),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'คำนวณค่าโดยสารแท็กซี่',
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF5BB7F5),
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 224, 123),
            ),
          ],
        ),
      ),
    );
  }
}
