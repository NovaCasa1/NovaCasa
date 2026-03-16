// lib/widgets/home_public_page.dart
// ─────────────────────────────────────────────────────────────────────────────
// PÁGINA PÚBLICA DE INICIO
// Es la primera página que ve el usuario al abrir la app, SIN necesidad de
// estar registrado. Muestra las propiedades disponibles y los botones de
// Login y Registro en la barra superior.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_Register/login_page.dart';    // para el botón "Iniciar Sesión"
import 'login_Register/register_Page.dart'; // para el botón "Registrarse"

class HomePublicPage extends StatefulWidget {
  const HomePublicPage({super.key});

  @override
  State<HomePublicPage> createState() => _HomePublicPageState();
}

class _HomePublicPageState extends State<HomePublicPage> {
  // ── ESTADO ───────────────────────────────────────────────────────────────────
  List<dynamic> _dwellings = []; // lista de propiedades que vienen del backend
  bool _isLoading = true;        // true mientras carga, false cuando termina

  // ── COLORES ───────────────────────────────────────────────────────────────────
  // Para cambiar los colores de toda la página, modifica solo aquí
  static const _blue = Color(0xFF007BFF); // azul principal
  static const _cyan = Color(0xFF98E9F0); // cian de botones secundarios
  static const _bg   = Color(0xFFF6F9FF); // color de fondo de la página
  static const _dark = Color(0xFF1A1F36); // color de textos oscuros
  static const _grey = Color(0xFF8A94A6); // color de textos secundarios

  // ── CICLO DE VIDA ─────────────────────────────────────────────────────────────
  // initState se ejecuta UNA SOLA VEZ al abrir la página
  // Aquí llamamos a _loadDwellings para cargar las propiedades del backend
  @override
  void initState() {
    super.initState();
    _loadDwellings(); // carga propiedades al abrir la página
  }

  // ── CARGA DE PROPIEDADES DESDE EL BACKEND ────────────────────────────────────
  // Hace una petición GET a la API y guarda las propiedades en _dwellings.
  // Si el backend no responde, simplemente muestra la lista vacía.
  // Para cambiar la URL del backend, modifica el Uri.parse de abajo.
  Future<void> _loadDwellings() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/dwellings'), // ← URL del backend
      );
      if (response.statusCode == 200) {
        setState(() {
          _dwellings = jsonDecode(response.body); // guarda las propiedades
          _isLoading = false;                     // deja de mostrar el spinner
        });
      } else {
        setState(() => _isLoading = false); // error del servidor → oculta spinner
      }
    } catch (e) {
      setState(() => _isLoading = false); // sin conexión → oculta spinner
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [

          // ── NAVBAR SUPERIOR ───────────────────────────────────────────────────
          // Barra con el logo y los botones de Login y Registro.
          // Para añadir más botones en la barra, agrégalos dentro del Row.
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            child: Row(
              children: [
                // Logo cuadrado azul con icono
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: _blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.terrain, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                // Nombre de la app
                const Text('NovaCasa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _dark)),
                const Spacer(), // empuja los botones hacia la derecha

                // Botón "Iniciar Sesión" → navega a LoginPage
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _blue,
                    side: const BorderSide(color: _blue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Iniciar Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),

                // Botón "Registrarse" → navega a RegisterPage
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Registrarse', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // ── CONTENIDO PRINCIPAL (scrollable) ─────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── BANNER HERO ─────────────────────────────────────────────
                  // Bloque azul grande de bienvenida con botón "Empezar ahora".
                  // Para cambiar el texto o el color del banner, modifica aquí.
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF007BFF), Color(0xFF0056CC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título principal del hero
                        const Text('Encuentra tu hogar ideal',
                            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        // Subtítulo del hero
                        const Text('Miles de propiedades en toda España',
                            style: TextStyle(color: Colors.white70, fontSize: 16)),
                        const SizedBox(height: 24),
                        // Botón CTA → lleva a RegisterPage
                        // Para que lleve al login en vez de registro, cambia RegisterPage por LoginPage
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterPage()),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _cyan,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Empezar ahora', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── ENCABEZADO DE SECCIÓN + CONTADOR ────────────────────────
                  // Muestra el título y cuántas propiedades hay en la BD.
                  // El contador solo aparece cuando _isLoading es false.
                  Row(
                    children: [
                      const Text('Propiedades disponibles',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _dark)),
                      const SizedBox(width: 10),
                      if (!_isLoading)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // Número de propiedades cargadas del backend
                          child: Text('${_dwellings.length}',
                              style: const TextStyle(color: _blue, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── GRID DE PROPIEDADES ──────────────────────────────────────
                  // Muestra un spinner mientras carga.
                  // Si no hay propiedades → muestra _buildEmptyState().
                  // Si hay propiedades → muestra el grid de tarjetas.
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _dwellings.isEmpty
                          ? _buildEmptyState()
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 320, // ancho máximo de cada tarjeta
                                childAspectRatio: 0.85,  // proporción alto/ancho
                                crossAxisSpacing: 20,    // espacio horizontal entre tarjetas
                                mainAxisSpacing: 20,     // espacio vertical entre tarjetas
                              ),
                              itemCount: _dwellings.length,
                              itemBuilder: (_, i) => _DwellingCard(dwelling: _dwellings[i]),
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── ESTADO VACÍO ──────────────────────────────────────────────────────────────
  // Se muestra cuando el backend responde pero no hay propiedades en la BD.
  // Para cambiar el mensaje, modifica los Text de abajo.
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.home_outlined, size: 64, color: _grey.withOpacity(0.4)),
            const SizedBox(height: 16),
            const Text('No hay propiedades aún',
                style: TextStyle(color: _grey, fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            const Text(
              'Las propiedades aparecerán aquí cuando se añadan a la base de datos',
              style: TextStyle(color: _grey, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TARJETA DE PROPIEDAD
// Muestra los datos de una propiedad individual que viene del backend.
// Los campos que muestra son: type, direction, city, rooms, meters, price.
// Si el backend añade más campos (ej: bathrooms), agrégalos aquí.
// ─────────────────────────────────────────────────────────────────────────────
class _DwellingCard extends StatelessWidget {
  final Map<String, dynamic> dwelling; // datos de una propiedad del backend

  const _DwellingCard({required this.dwelling});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Badge del tipo de propiedad (Piso, Villa, Estudio...)
            // dwelling['type'] viene del campo "type" de la tabla Dwelling en la BD
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF007BFF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                dwelling['type'] ?? 'Propiedad', // ?? 'Propiedad' es el valor por defecto
                style: const TextStyle(color: Color(0xFF007BFF), fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // Dirección de la propiedad
            // dwelling['direction'] viene del campo "direction" de la BD
            Text(
              dwelling['direction'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1A1F36)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // corta el texto si es muy largo
            ),
            const SizedBox(height: 6),

            // Ciudad y país — solo se muestra si la propiedad tiene ciudad asignada
            // dwelling['city'] es el objeto City relacionado (viene del include en la API)
            if (dwelling['city'] != null)
              Row(children: [
                const Icon(Icons.location_on, color: Color(0xFF8A94A6), size: 13),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    '${dwelling['city']['name']}, ${dwelling['city']['country']}',
                    style: const TextStyle(color: Color(0xFF8A94A6), fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),

            const Spacer(), // empuja el precio y los iconos hacia abajo

            // Habitaciones y metros cuadrados
            Row(children: [
              const Icon(Icons.bed_outlined, color: Color(0xFF8A94A6), size: 14),
              const SizedBox(width: 4),
              Text('${dwelling['rooms']}',   // número de habitaciones
                  style: const TextStyle(color: Color(0xFF8A94A6), fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(Icons.straighten, color: Color(0xFF8A94A6), size: 14),
              const SizedBox(width: 4),
              Text('${dwelling['meters']} m²', // metros cuadrados
                  style: const TextStyle(color: Color(0xFF8A94A6), fontSize: 12)),
            ]),
            const SizedBox(height: 8),

            // Precio de la propiedad
            // dwelling['price'] viene del campo "price" de la BD
            Text(
              '€ ${dwelling['price']}',
              style: const TextStyle(color: Color(0xFF007BFF), fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}