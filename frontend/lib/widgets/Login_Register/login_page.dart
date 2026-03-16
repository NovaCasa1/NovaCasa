// lib/widgets/login_Register/login_page.dart
// ─────────────────────────────────────────────────────────────────────────────
// PÁGINA DE LOGIN (versión web)
// Muestra un formulario de email y contraseña.
// Al pulsar "Continuar" llama al backend y si las credenciales son correctas
// navega a la HomePage pasando los datos del usuario.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // para hacer llamadas al backend
import 'dart:convert';                   // para jsonEncode y jsonDecode
import 'register_Page.dart';             // para navegar al registro
import '../homePage.dart';               // para navegar al home tras login
import '../../models/user_model.dart';   // modelo que representa al usuario

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // ── CONTROLADORES ────────────────────────────────────────────────────────────
  // Cada controlador está vinculado a un campo de texto.
  // Para leer el valor que escribió el usuario usa: _emailController.text
  final _emailController    = TextEditingController(); // campo email
  final _passwordController = TextEditingController(); // campo contraseña

  // ── ESTADO LOCAL ─────────────────────────────────────────────────────────────
  bool    _rememberMe   = false; // controla el checkbox "Recordar contraseña"
  bool    _isLoading    = false; // true mientras espera respuesta del backend
  String? _errorMessage;         // mensaje de error visible en pantalla (null = oculto)

  // ── URL DEL BACKEND ───────────────────────────────────────────────────────────
  // Cambia esta URL si el backend está en otro servidor o puerto
  static const _apiUrl = 'http://localhost:3000';

  // ── LÓGICA DE LOGIN ───────────────────────────────────────────────────────────
  // Se ejecuta al pulsar el botón "Continuar"
  // 1. Valida que los campos no estén vacíos
  // 2. Llama al endpoint POST /api/auth/login
  // 3. Si responde 200 → navega a HomePage con los datos del usuario
  // 4. Si responde error → muestra el mensaje de error en pantalla
  Future<void> _handleLogin() async {

    // Validación — si algún campo está vacío muestra error y para
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Por favor completa todos los campos');
      return;
    }

    // Activa el spinner y limpia errores anteriores
    setState(() { _isLoading = true; _errorMessage = null; });

    try {
      // Llamada HTTP POST al backend
      // Envía email y contraseña en formato JSON
      final response = await http.post(
        Uri.parse('$_apiUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email':    _emailController.text.trim(), // trim() elimina espacios
          'password': _passwordController.text,
        }),
      );

      // Convierte la respuesta JSON a un Map de Dart
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Login exitoso → crea el modelo de usuario con los datos del backend
        // y navega a HomePage reemplazando la pantalla actual (no se puede volver atrás)
        final user = UserModel.fromJson(data['user']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
        );
      } else {
        // Error del backend (email/contraseña incorrectos, etc.)
        // data['message'] viene del backend, si no existe usa el mensaje por defecto
        setState(() => _errorMessage = data['message'] ?? 'Error al iniciar sesión');
      }
    } catch (e) {
      // Error de red — el backend no está arrancado o no hay conexión
      // Asegúrate de tener npm run dev ejecutándose en el backend
      setState(() => _errorMessage = 'No se pudo conectar al servidor');
    } finally {
      // Siempre desactiva el spinner, haya error o no
      setState(() => _isLoading = false);
    }
  }

  // ── LIMPIEZA ──────────────────────────────────────────────────────────────────
  // dispose se llama cuando se destruye la página
  // Es importante liberar los controladores para evitar memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // ── TAMAÑO RESPONSIVE ─────────────────────────────────────────────────────
    // La tarjeta se adapta al tamaño de la ventana del navegador.
    // clamp(min, max) garantiza que nunca sea menor de 0 ni mayor de 600/900
    // Para ajustar el tamaño máximo de la tarjeta, cambia los valores 600 y 900
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth  = MediaQuery.of(context).size.width;
    final cardHeight   = (screenHeight * 0.9).clamp(0.0, 600.0);
    final cardWidth    = (screenWidth  * 0.9).clamp(0.0, 900.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // SingleChildScrollView evita el overflow si la pantalla es muy pequeña
        child: SingleChildScrollView(
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

                // ── LADO IZQUIERDO: FORMULARIO AZUL ────────────────────────────
                // flex: 4 significa que ocupa 4/9 del ancho total de la tarjeta
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFF007BFF), // azul principal
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
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

                        // Título y subtítulo del formulario
                        // Para cambiar el texto modifica los String de abajo
                        const Text('Iniciar Sesión',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                        const Text('Bienvenidos, por favor introduce tus credenciales',
                            style: TextStyle(color: Colors.white70, fontSize: 13)),
                        const SizedBox(height: 24),

                        // Campo email
                        const Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _buildTextField(_emailController, 'Introduce el email'),
                        const SizedBox(height: 16),

                        // Campo contraseña — isPassword: true oculta el texto
                        const Text('Contraseña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _buildTextField(_passwordController, '', isPassword: true),

                        // Checkbox "Recordar contraseña"
                        // _rememberMe guarda el estado true/false del checkbox
                        // Para usar este valor al hacer login, inclúyelo en el jsonEncode
                        Row(children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (val) => setState(() => _rememberMe = val!),
                            side: const BorderSide(color: Colors.white),
                            checkColor: Colors.blue,
                            activeColor: Colors.white,
                          ),
                          const Text('Recordar contraseña',
                              style: TextStyle(color: Colors.white, fontSize: 12)),
                        ]),

                        // Mensaje de error — solo visible cuando _errorMessage != null
                        // El texto viene del backend o de la validación local
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

                        const SizedBox(height: 8),

                        // Botón "Continuar"
                        // onPressed: null desactiva el botón mientras carga (_isLoading)
                        // Cuando _isLoading es true muestra un spinner en vez del texto
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
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
                                : const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),

                        const Spacer(), // empuja el link hacia abajo

                        // Link "¿No te has registrado? Registrate"
                        // pushReplacement reemplaza LoginPage por RegisterPage en la pila
                        // así el botón atrás del navegador va a HomePublicPage, no al login
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterPage()),
                            ),
                            child: const Text.rich(TextSpan(
                              text: '¿No te has registrado? ',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                              children: [
                                TextSpan(
                                  text: 'Registrate',
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

                // ── LADO DERECHO: IMAGEN ────────────────────────────────────────
                // flex: 5 significa que ocupa 5/9 del ancho total de la tarjeta
                // Para cambiar la imagen modifica el NetworkImage de abajo
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      image: DecorationImage(
                        // ← CAMBIA ESTA URL para usar otra imagen
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1503220317375-aaad61436b1b?q=80&w=2070',
                        ),
                        fit: BoxFit.cover,
                      ),
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
  // Se usa para todos los campos del formulario.
  // controller → vincula el campo con el controlador para leer su valor
  // hint       → texto gris de ayuda dentro del campo
  // isPassword → true oculta el texto (para contraseñas)
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
        obscureText: isPassword, // true → muestra puntos en vez de letras
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          border: InputBorder.none, // sin borde visible
        ),
      ),
    );
  }
}