import 'package:flutter/material.dart';
import 'widgets/login_Register/login_page.dart';
import 'widgets/homePage.dart';


void main() {
  runApp(const MyApp());
}
//Prueba para hector
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The MaterialApp widget is the top-level widget for a Flutter application that
    return MaterialApp(
      title: 'NovaCasa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
