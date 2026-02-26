import 'package:flutter/material.dart';
import 'pages/mobLogin.dart';
import 'components/custom_app_bar.dart';

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
      home: MobLoginPage(), // Arranca en LoginPage
    );
  }
}