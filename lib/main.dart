import 'package:flutter/material.dart';
import 'package:practice/pages/startPage.dart';
import 'package:practice/pages/todoListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyOnboarding(),
    );
  }
}
