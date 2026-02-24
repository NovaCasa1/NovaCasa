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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome to NovaCasa 🏠",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your real estate journey starts here.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // 🌟 Sección Destacados
            const Text(
              "Featured Properties",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _propertyCard("Modern Apartment", "assets/images/property1.jpg"),
                  _propertyCard("Cozy House", "assets/images/property2.jpg"),
                  _propertyCard("Luxury Villa", "assets/images/property3.jpg"),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 🔹 Sección Acciones rápidas
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionCard(Icons.search, "Search"),
                _actionCard(Icons.favorite, "Favorites"),
                _actionCard(Icons.person, "Profile"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget para propiedades destacadas
  Widget _propertyCard(String title, String imagePath) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8),
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 🔹 Widget para acciones rápidas
  Widget _actionCard(IconData icon, String label) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue[800]),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}