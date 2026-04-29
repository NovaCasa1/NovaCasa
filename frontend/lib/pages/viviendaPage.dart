import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'layouts/desktop_layout.dart';

class ViviendaPage extends StatelessWidget {
  const ViviendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viviendas = [
      {
        'titulo': 'Ático en Melide',
        'precio': '2.600',
        'habitaciones': '4',
        'metros': '170',
        'planta': '3',
        'ascensor': 'con ascensor',
        'descripcion':
            'Ofrecemos en alquiler un elegante apartamento ubicado en una tranquila zona de Melide, en un complejo residencial con pocas unidades.',
        'imagen': 'assets/images/vivienda_servicios.jpg',
      },
      {
        'titulo': 'Ático en Melide',
        'precio': '2.600',
        'habitaciones': '4',
        'metros': '170',
        'planta': '3',
        'ascensor': 'con ascensor',
        'descripcion':
            'Ofrecemos en alquiler un elegante apartamento ubicado en una tranquila zona de Melide, en un complejo residencial con pocas unidades.',
        'imagen': 'assets/images/vivienda_servicios.jpg',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DesktopLayout(viviendas: viviendas),
        ),
      ),
    );
  }
}
