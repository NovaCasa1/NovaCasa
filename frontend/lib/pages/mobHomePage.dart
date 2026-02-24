import 'package:flutter/material.dart';
import '../components/mobApp_bar.dart';

class MobHomePage extends StatelessWidget {
  const MobHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobAppBar(
        title: "Home",
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            Text(
              "Welcome to NovaCasa 🏠",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your real estate journey starts here.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}