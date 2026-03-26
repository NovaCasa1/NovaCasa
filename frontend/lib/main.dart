import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'pages/mobLogin.dart';
import 'pages/homePage.dart';
import 'pages/banderas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb ? WebLoginPage() : MobLoginPage(),
      routes: {
        '/banderas': (context) => const BanderasPage(),
      },
    );
  }
}