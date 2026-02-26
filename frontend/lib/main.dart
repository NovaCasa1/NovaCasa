import 'package:flutter/material.dart';
import 'pages/mobLogin.dart';
import 'widgets/login_Register/login_page.dart';
// import 'widgets/homePage.dart';


void main() {
  runApp(MyApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Arranca en LoginPage
      routes: {
        '/login': (context) => const LoginPage(),
        // '/home': (context) => const HomePage(),
      },
    );
  }
}