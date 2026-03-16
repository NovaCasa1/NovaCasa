// lib/widgets/login_Register/register_Page.dart
// ─────────────────────────────────────────────────────────────────────────────
// PÁGINA DE REGISTRO (versión web)
// Muestra un formulario con nombre, apellido, email, teléfono y contraseña.
// Al pulsar "Registrarse" inserta el usuario en la base de datos PostgreSQL
// y navega directamente a HomePage sin pasar por el login.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';             // para navegar al login desde el link
import '../homePage.dart';            // para navegar al home tras registro
import '../../models/user_model.dart'; // modelo del usuario

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // ── CONTROLADORES ────────────────────────────────────────────────────────────
  // Un controlador por cada campo del formulario.
  // Para añadir un campo nuevo: crea su controlador, añádelo al dispose()
  // y agrégalo al jsonEncode del _handleRegister
  final _nameController      = TextEditingController(); // campo nombre
  final _surnameController   = TextEditingController(); // campo apellido
  final _emailController     = TextEditingController(); // campo email
  final _passwordController  = TextEditingController(); // campo contraseña
  final _telephoneController = TextEditingController(); // campo teléfono

  // ── ESTADO LOCAL ─────────────────────────────────────────────────────────────
  bool    _isLoading    = false; // true mientras espera respuesta del backend
  String? _errorMessage;         // mensaje de error (null = oculto)

  // ── URL DEL BACKEND ───────────────────────────────────────────────────────────
  // Cambia esta URL si el backend está en otro servidor o puerto
  static const _apiUrl = 'http://localhost:3000';

  // ── LÓGICA DE REGISTRO ────────────────────────────────────────────────────────
  // Se ejecuta al pulsar el botón "Registrarse"
  // 1. Valida que todos los campos estén rellenos
  // 2. Llama al endpoint POST /api/auth/register
  // 3. Si responde 201 → crea el usuario en la BD y navega a HomePage
  // 4. Si responde error → muestra el mensaje de error en pantalla
  Future<void> _handleRegister() async {

    // Validación — todos los campos son obligatorios
    // Para hacer un campo opcional, quítalo de esta condición
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _telephoneController.text.isEmpty) {
      setState(() => _errorMessage = 'Por favor completa todos los campos');
      return;
    }

    // Activa el spinner y limpia errores anteriores
    setState(() { _isLoading = true; _errorMessage = null; });

    try {
      // Llamada HTTP POST al backend
      // Estos campos deben coincidir exactamente con los que espera auth.routes.ts
      // Si añades campos al schema de Prisma, agrégalos aquí también
      final response = await http.post(
        Uri.parse('$_apiUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name':      _nameController.text.trim(),
          'surname':   _surnameController.text.trim(),
          'email':     _emailController.text.trim(),
          'password':  _passwordController.text,
          'telephone': _telephoneController.text.trim(),
          'birthdate': '1990-01-01T00:00:00.000Z', // ← pendiente: añadir DatePicker
          'countryId': 1,                           // ← pendiente: añadir selector de país
          'eu':        true,                        // ← pendiente: añadir checkbox
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Registro exitoso → el backend devuelve los datos del usuario creado
        // pushAndRemoveUntil elimina TODA la pila de navegación
        // así el botón atrás no vuelve al registro ni al login
        final user = UserModel.fromJson(data['user']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
          (route) => false, // false = elimina todas las rutas anteriores
        );
      } else {
        // Error del backend (email ya registrado, campos inválidos, etc.)
        setState(() => _errorMessage = data['message'] ?? 'Error al registrarse');
      }
    } catch (e) {
      // Error de red — el backend no está arrancado o no hay conexión
      setState(() => _errorMessage = 'No se pudo conectar al servidor');
    } finally {
      // Siempre desactiva el spinner
      setState(() => _isLoading = false);
    }
  }

  // ── LIMPIEZA ──────────────────────────────────────────────────────────────────
  // Libera todos los controladores al destruir la página
  // Si añades un controlador nuevo, agrégalo aquí también
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // ── TAMAÑO RESPONSIVE ─────────────────────────────────────────────────────
    // El register tiene más campos que el login, por eso usa 0.95 en vez de 0.9
    // y el máximo es 700 en vez de 600
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth  = MediaQuery.of(context).size.width;
    final cardHeight   = (screenHeight * 0.95).clamp(0.0, 700.0);
    final cardWidth    = (screenWidth  * 0.9).clamp(0.0, 900.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView( // evita overflow si la pantalla es pequeña
          child: Container(
            margin: const EdgeInsets.all(20),
            height: cardHeight,
            width:  cardWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 5),
              ],
            ),
            child: Row(
              children: [

                // ── LADO IZQUIERDO: IMAGEN ──────────────────────────────────────
                // En el register la imagen va a la IZQUIERDA (al contrario que el login)
                // flex: 5 → ocupa 5/9 del ancho
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                      image: const DecorationImage(
                        // ← CAMBIA ESTA URL para usar otra imagen
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1503220317375-aaad61436b1b?q=80&w=2070',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      // Degradado azul sobre la imagen para suavizar la transición
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                        gradient: LinearGradient(
                          colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
                          begin: Alignment.centerRight, // degradado de derecha a izquierda
                          end: Alignment.centerLeft,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── LADO DERECHO: FORMULARIO AZUL ──────────────────────────────
                // flex: 4 → ocupa 4/9 del ancho
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                    decoration: const BoxDecoration(
                      color: Color(0xFF007BFF),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                       // Logo — al pulsar vuelve a HomePublicPage
                          GestureDetector(
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false, // limpia toda la pila
                            ),
                            child: Row(children: [
                              const Icon(Icons.terrain, color: Colors.white, size: 30),
                              const SizedBox(width: 8),
                              const Text('NovaCasa',
                                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            ]),
                          ),

                        // Título y subtítulo
                        const Text('Crear Cuenta',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                        const Text('Introduce tus datos para registrarte',
                            style: TextStyle(color: Colors.white70, fontSize: 13)),
                        const SizedBox(height: 16),

                        // Campos del formulario
                        // Para añadir un campo nuevo: copia uno de estos bloques
                        // y crea su controlador arriba
                        const Text('Nombre', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        _buildTextField(_nameController, 'Introduce tu nombre'),
                        const SizedBox(height: 10),

                        const Text('Apellido', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        _buildTextField(_surnameController, 'Introduce tu apellido'),
                        const SizedBox(height: 10),

                        const Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        _buildTextField(_emailController, 'Introduce el email'),
                        const SizedBox(height: 10),

                        const Text('Teléfono', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        _buildTextField(_telephoneController, 'Introduce tu teléfono'),
                        const SizedBox(height: 10),

                        const Text('Contraseña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        _buildTextField(_passwordController, '', isPassword: true),
                        const SizedBox(height: 10),

                        // Mensaje de error — solo visible si _errorMessage != null
                        if (_errorMessage != null)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(_errorMessage!,
                                style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),

                        // Botón "Registrarse"
                        // Desactivado mientras _isLoading es true
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF98E9F0),
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20, width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black54),
                                  )
                                : const Text('Registrarse', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),

                        const Spacer(), // empuja el link hacia abajo

                        // Link "¿Ya tienes cuenta? Inicia sesión"
                        // pushReplacement reemplaza RegisterPage por LoginPage
                        // funciona aunque no haya página anterior en la pila
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                            ),
                            child: const Text.rich(TextSpan(
                              text: '¿Ya tienes cuenta? ',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                              children: [
                                TextSpan(
                                  text: 'Inicia sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── CAMPO DE TEXTO REUTILIZABLE ───────────────────────────────────────────────
  // Igual que en LoginPage. Para cambiar el estilo de los campos
  // modifica solo este método y afectará a todos los campos del formulario.
  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 4)),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}