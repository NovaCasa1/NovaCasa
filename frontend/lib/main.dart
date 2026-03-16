import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'pages/mobLogin.dart';
<<<<<<< HEAD
import 'widgets/login_Register/login_page.dart';
// import 'widgets/homePage.dart';

=======
import 'pages/homePage.dart';
>>>>>>> 8e3c96ce18ac048a17a3ab81c8eacce689feef50

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
<<<<<<< HEAD
      home: const LoginPage(), // Arranca en LoginPage
      routes: {
        '/login': (context) => const LoginPage(),
        // '/home': (context) => const HomePage(),
      },
=======
      home: kIsWeb ? WebLoginPage() : MobLoginPage(),
>>>>>>> 8e3c96ce18ac048a17a3ab81c8eacce689feef50
    );
  }
}