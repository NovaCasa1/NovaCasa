import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class BanderasPage extends StatelessWidget {
  const BanderasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> banderas = [
      {'nombre': 'Suecia', 'imagen': 'assets/images/sueciaB.png'},
      {'nombre': 'Irlanda', 'imagen': 'assets/images/irlandaB.png'},
      {'nombre': 'Suiza', 'imagen': 'assets/images/suizaB.png'},
      {'nombre': 'Noruega', 'imagen': 'assets/images/noruegaB.png'},
      {'nombre': 'Inglaterra', 'imagen': 'assets/images/inglaterraB.png'},
      {'nombre': 'Italia', 'imagen': 'assets/images/italiaB.png'},
      {'nombre': 'Chipre', 'imagen': 'assets/images/chipreB.png'},
      {'nombre': 'Grecia', 'imagen': 'assets/images/greciaB.png'},
      {'nombre': 'Letonia', 'imagen': 'assets/images/letoniaB.png'},
      {'nombre': 'Alemania', 'imagen': 'assets/images/alemaniaB.png'},
      {'nombre': 'Finlandia', 'imagen': 'assets/images/finlandiaB.png'},
      {'nombre': 'Portugal', 'imagen': 'assets/images/portugalB.png'},
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Banderas del Mundo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: banderas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${banderas[index]['nombre']}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                            width: 160,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Image.asset(
                                banderas[index]['imagen']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                            child: Text(
                              banderas[index]['nombre']!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
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
