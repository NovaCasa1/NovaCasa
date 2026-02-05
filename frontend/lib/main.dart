<<<<<<< HEAD
/// Top-level entry library for tests and tooling.
/// Re-exports the app so tests can import `package:flutterproject/main.dart`.
export 'pages/main.dart';
=======
import 'package:flutter/material.dart';
import '../widgets/login_page.dart';
import 'homePage.dart';

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
>>>>>>> bae10f8f2d7c316cde1a886162a1acd7a2cbffc6
