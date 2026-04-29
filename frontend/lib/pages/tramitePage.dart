import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class TramitePage extends StatefulWidget {
  const TramitePage({super.key});

  @override
  State<TramitePage> createState() => _TramitePageState();
}

class _TramitePageState extends State<TramitePage> {
  final List<Map<String, dynamic>> tramites = [
    {
      'titulo': 'Registro en la oficina de empadronamiento',
      'descripcion':
          'Ofrecemos en alquiler un elegante apartamento duplex situado en una zona tranquila de Melide, en un complejo residencial con pocas unidades.',
      'completado': false,
    },
    {
      'titulo': 'Título del trámite',
      'descripcion':
          'Ofrecemos en alquiler un elegante apartamento duplex situado en una zona tranquila de Melide, en un complejo residencial con pocas unidades.',
      'completado': false,
    },
    {
      'titulo': 'Título del trámite (Opcional si eres fuera de la EU)',
      'descripcion':
          'Ofrecemos en alquiler un elegante apartamento duplex situado en una zona tranquila de Melide, en un complejo residencial con pocas unidades.',
      'completado': false,
    },
    {
      'titulo': 'Título del trámite',
      'descripcion':
          'Ofrecemos en alquiler un elegante apartamento duplex situado en una zona tranquila de Melide, en un complejo residencial con pocas unidades.',
      'completado': false,
    },
    {
      'titulo': 'Título del trámite',
      'descripcion':
          'Ofrecemos en alquiler un elegante apartamento duplex situado en una zona tranquila de Melide, en un complejo residencial con pocas unidades.',
      'completado': false,
    },
  ];

  int get completados => tramites.where((t) => t['completado'] == true).length;
  int get total => tramites.length;

  void toggleTramite(int index) {
    setState(() {
      tramites[index]['completado'] = !tramites[index]['completado'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header con contador
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Trámites',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$completados/$total',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Lista de trámites
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tramites.length,
                itemBuilder: (context, index) {
                  final tramite = tramites[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => toggleTramite(index),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.cyan[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox
                            Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.only(top: 2, right: 16),
                              decoration: BoxDecoration(
                                color: tramite['completado']
                                    ? Colors.blue
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: tramite['completado']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                            // Contenido
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tramite['titulo']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      decoration: tramite['completado']
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    tramite['descripcion']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      decoration: tramite['completado']
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
