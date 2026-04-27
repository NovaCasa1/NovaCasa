import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

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
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viviendas.length,
            itemBuilder: (context, index) {
              final vivienda = viviendas[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            vivienda['imagen']!,
                            width: 180,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Contenido
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vivienda['titulo']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '${vivienda['precio']}€',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Text(
                                    '/mes',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${vivienda['habitaciones']} hab. • ${vivienda['metros']} m² • Planta ${vivienda['planta']} • ${vivienda['ascensor']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                vivienda['descripcion']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.phone),
                                label: const Text('Ver teléfono'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Icono de favorito
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_border),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
