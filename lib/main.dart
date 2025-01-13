import 'package:flutter/material.dart';
import 'screens/lib/screens/splash.dart';// Adjust the import patt

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}
