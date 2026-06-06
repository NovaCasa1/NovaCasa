import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../services/api_service.dart';
import 'layouts/vivienda_card.dart';

class ViviendaPage extends StatefulWidget {
  const ViviendaPage({super.key});

  @override
  State<ViviendaPage> createState() => _ViviendaPageState();
}

class _ViviendaPageState extends State<ViviendaPage> {
  late Future<List<Map<String, dynamic>>> _viviendasFuture;

  @override
  void initState() {
    super.initState();
    _viviendasFuture = ApiService.getViviendas();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _viviendasFuture,
        builder: (context, snapshot) {
          // Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _viviendasFuture = ApiService.getViviendas();
                    }),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          // Sin datos
          final viviendas = snapshot.data ?? [];
          if (viviendas.isEmpty) {
            return const Center(child: Text('No hay viviendas disponibles'));
          }

          // Lista / Grid
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isMobile
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viviendas.length,
                      itemBuilder: (context, index) =>
                          ViviendaCard(vivienda: viviendas[index]),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 1200 ? 3 : 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: viviendas.length,
                      itemBuilder: (context, index) =>
                          ViviendaCard(vivienda: viviendas[index]),
                    ),
            ),
          );
        },
      ),
    );
  }
}
