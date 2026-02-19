import 'package:flutter/material.dart';
import './app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Welcome to NovaCasa'),
      ),
    );
  }
}
