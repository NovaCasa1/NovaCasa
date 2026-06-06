import 'package:flutter/material.dart';
import '../../../components/custom_app_bar.dart';
import '../../../services/api_service.dart';
import '../../../documentosNovaCasa/layouts/empleo_card.dart';

class EmpleosPage extends StatefulWidget {
  const EmpleosPage({super.key});

  @override
  State<EmpleosPage> createState() => _EmpleosPageState();
}

class _EmpleosPageState extends State<EmpleosPage> {
  late Future<List<Map<String, dynamic>>> _empleosFuture;

  @override
  void initState() {
    super.initState();
    _empleosFuture = ApiService.getEmpleos();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _empleosFuture,
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
                      _empleosFuture = ApiService.getEmpleos();
                    }),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          // Sin datos
          final empleos = snapshot.data ?? [];
          if (empleos.isEmpty) {
            return const Center(child: Text('No hay ofertas de empleo disponibles'));
          }

          // Lista / Grid
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isMobile
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: empleos.length,
                      itemBuilder: (context, index) =>
                          EmpleoCard(empleo: empleos[index]),
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
                      itemCount: empleos.length,
                      itemBuilder: (context, index) =>
                          EmpleoCard(empleo: empleos[index]),
                    ),
            ),
          );
        },
      ),
    );
  }
}
