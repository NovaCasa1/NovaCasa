// lib/widgets/login_Register/register_Page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../homePage.dart';
import '../../models/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController      = TextEditingController();
  final _surnameController   = TextEditingController();
  final _emailController     = TextEditingController();
  final _passwordController  = TextEditingController();
  final _telephoneController = TextEditingController();
  bool   _isLoading    = false;
  String? _errorMessage;

  static const _apiUrl = 'http://localhost:3000';

  Future<void> _handleRegister() async {
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _telephoneController.text.isEmpty) {
      setState(() => _errorMessage = 'Por favor completa todos los campos');
      return;
    }

    setState(() { _isLoading = true; _errorMessage = null; });

    try {
      final response = await http.post(
        Uri.parse('$_apiUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name':      _nameController.text.trim(),
          'surname':   _surnameController.text.trim(),
          'email':     _emailController.text.trim(),
          'password':  _passwordController.text,
          'telephone': _telephoneController.text.trim(),
          'birthdate': '1990-01-01T00:00:00.000Z',
          'countryId': 1,
          'eu':        true,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Registro exitoso → ir directo a HomePage sin pasar por login
        final user = UserModel.fromJson(data['user']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
          (route) => false,
        );
      } else {
        setState(() => _errorMessage = data['message'] ?? 'Error al registrarse');
      }
    } catch (e) {
      setState(() => _errorMessage = 'No se pudo conectar al servidor');
    } finally {
      setState(() => _isLoading = false);
    }
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 640,
          width: 900,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 5),
            ],
          ),
          child: Row(
            children: [
              // ── IMAGEN ───────────────────────────────────
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1503220317375-aaad61436b1b?q=80&w=2070',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
              ),

              // ── FORMULARIO AZUL ──────────────────────────
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
                      // Logo
                      Row(children: [
                        const Icon(Icons.terrain, color: Colors.white, size: 30),
                        const SizedBox(width: 8),
                        const Text('NovaCasa',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ]),
                      const SizedBox(height: 24),
                      const Text('Crear Cuenta',
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      const Text('Introduce tus datos para registrarte',
                          style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 20),

                      const Text('Nombre', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      _buildTextField(_nameController, 'Introduce tu nombre'),
                      const SizedBox(height: 12),

                      const Text('Apellido', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      _buildTextField(_surnameController, 'Introduce tu apellido'),
                      const SizedBox(height: 12),

                      const Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      _buildTextField(_emailController, 'Introduce el email'),
                      const SizedBox(height: 12),

                      const Text('Teléfono', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      _buildTextField(_telephoneController, 'Introduce tu teléfono'),
                      const SizedBox(height: 12),

                      const Text('Contraseña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      _buildTextField(_passwordController, '', isPassword: true),
                      const SizedBox(height: 12),

                      // Mensaje de error
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

                      // Botón Registrarse
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
                              ? const SizedBox(height: 20, width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black54))
                              : const Text('Registrarse', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),

                      const Spacer(),

                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
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
    );
  }

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