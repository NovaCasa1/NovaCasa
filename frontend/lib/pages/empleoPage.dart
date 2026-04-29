import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'layouts/empleo_desktop_layout.dart';

class EmpleoPage extends StatelessWidget {
  const EmpleoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final empleos = [
      {
        'puesto': 'Desarrollador Flutter',
        'empresa': 'TechCorp',
        'ubicacion': 'Madrid',
        'tipo': 'Tiempo Completo',
        'salario': '2.000€ - 2.500€',
        'descripcion':
            'Buscamos desarrollador Flutter experimentado para unirse a nuestro equipo de innovación. Experiencia mínima 3 años.',
      },
      {
        'puesto': 'Analista de Datos',
        'empresa': 'DataFlow',
        'ubicacion': 'Barcelona',
        'tipo': 'Remoto',
        'salario': '1.800€ - 2.300€',
        'descripcion':
            'Se requiere especialista en análisis de datos con Python y SQL. Trabajarás en proyectos de machine learning.',
      },
      {
        'puesto': 'Diseñador UX/UI',
        'empresa': 'Creative Studio',
        'ubicacion': 'Valencia',
        'tipo': 'Híbrido',
        'salario': '1.600€ - 2.000€',
        'descripcion':
            'Diseñador creativo con experiencia en aplicaciones móviles. Portfolio obligatorio. Equipo dinámico y colaborativo.',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DesktopLayout(empleos: empleos),
        ),
      ),
    );
  }
}
