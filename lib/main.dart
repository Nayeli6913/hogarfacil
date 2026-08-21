import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const HogarFacilApp());
}

class HogarFacilApp extends StatelessWidget {
  const HogarFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HogarFácil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}