import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'viviendaPage.dart';
import 'empleoPage.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16.0 : 40.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Nuestros Servicios',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 1 : 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
                children: [
                  _ServiceCard(
                    titulo: 'Empleo',
                    imagen: 'assets/images/empleo_servicios.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmpleoPage(),
                        ),
                      );
                    },
                  ),
                  _ServiceCard(
                    titulo: 'Viviendas',
                    imagen: 'assets/images/vivienda_servicios.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViviendaPage(),
                        ),
                      );
                    },
                  ),
                  _ServiceCard(
                    titulo: 'Trámites',
                    imagen: 'assets/images/tramites.jpg',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String titulo;
  final String imagen;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.titulo,
    required this.imagen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              imagen,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Center(
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
