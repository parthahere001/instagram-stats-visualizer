import 'package:flutter/material.dart';
import 'instagram_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instaviz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF212121),
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const InstagramScreen(),
    );
  }
}
