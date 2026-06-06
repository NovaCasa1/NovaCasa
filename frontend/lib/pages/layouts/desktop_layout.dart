import 'package:flutter/material.dart';
import 'vivienda_card.dart';

class DesktopLayout extends StatelessWidget {
  final List<Map<String, dynamic>> viviendas;

  const DesktopLayout({required this.viviendas});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      // Mobile: lista vertical
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viviendas.length,
        itemBuilder: (context, index) {
          return ViviendaCard(vivienda: viviendas[index]);
        },
      );
    }

    // Desktop: grid
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: viviendas.length,
      itemBuilder: (context, index) {
        return ViviendaCard(vivienda: viviendas[index]);
      },
    );
  }
}
