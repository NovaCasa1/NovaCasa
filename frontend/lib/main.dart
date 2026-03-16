// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/mobLogin.dart';
import 'widgets/home_public_page.dart';
import 'widgets/login_Register/login_page.dart';
import 'widgets/login_Register/register_Page.dart';
import 'widgets/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaCasa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007BFF)),
        useMaterial3: true,
      ),
      home: const HomePublicPage(),
      routes: {
        '/home':     (context) => const HomePublicPage(),
        '/login':    (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}