import 'package:flutter/material.dart';

class ViviendaCard extends StatelessWidget {
  final Map<String, dynamic> vivienda;

  const ViviendaCard({required this.vivienda});

  Widget _buildImage() {
    final imagen = vivienda['imagen'] as String?;
    if (imagen == null) {
      return _buildPlaceholder();
    }

    if (imagen.startsWith('http')) {
      return Image.network(
        imagen,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }

    return Image.asset(
      imagen,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder();
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.grey[300],
      child: const Icon(Icons.image, size: 64, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titulo = vivienda['titulo'] ?? 'Sin título';
    final precio = vivienda['precio'] ?? '0';
    final metros = vivienda['metros'] ?? '0';
    final habitaciones = vivienda['habitaciones'] ?? '0';
    final bathrooms = vivienda['bathrooms'] ?? 'N/A';
    final tipo = vivienda['tipo'] ?? 'Vivienda';
    final descripcion = vivienda['descripcion'] ?? '';
    final ciudad = vivienda['ciudad'] ?? '';
    final portal = vivienda['portal'] ?? 'NovaCasa';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con badge de portal
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: _buildImage(),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      portal,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Contenido
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Ciudad y tipo
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '$ciudad • $tipo',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Precio destacado
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B4CE6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '€$precio',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B4CE6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Características en grid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeature(
                        icon: Icons.door_front_door,
                        label: '$habitaciones hab',
                      ),
                      _buildFeature(
                        icon: Icons.bathroom,
                        label: '$bathrooms baños',
                      ),
                      _buildFeature(
                        icon: Icons.square_foot,
                        label: '$metros m²',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Características destacadas (badges)
                  if (vivienda['caracteristicas'] != null)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: (vivienda['caracteristicas'] as List)
                          .take(4)
                          .map<Widget>((item) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(
                              color: Colors.blue[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[900],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 12),
                  // Descripción
                  Text(
                    descripcion,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Botón de contacto
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario de contacto'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.mail, size: 18),
                      label: const Text('Contactar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B4CE6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6B4CE6)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

