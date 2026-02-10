import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          // Contenedor principal con sombra suave
          margin: const EdgeInsets.all(20),
          height: 550,
          width: 900,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child: Row(
            children: [
              // LADO IZQUIERDO: FORMULARIO AZUL
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  decoration: const BoxDecoration(
                    color: Color(0xFF007BFF), // Azul vibrante de la imagen
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo NovaCasa
                      Row(
                        children: [
                          const Icon(Icons.terrain, color: Colors.white, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            'NovaCasa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Iniciar Sesion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Bienvenidos, por favor introduce tus credenciales',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 30),
                      
                      // Campo Email
                      const Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildTextField(_emailController, 'Introduce el email'),
                      
                      const SizedBox(height: 20),
                      
                      // Campo Contraseña
                      const Text('Contraseña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildTextField(_passwordController, '', isPassword: true),
                      
                      // Checkbox Recordar
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (val) => setState(() => _rememberMe = val!),
                            side: const BorderSide(color: Colors.white),
                            checkColor: Colors.blue,
                            activeColor: Colors.white,
                          ),
                          const Text('Recordar contraseña', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Botón Continuar (Cian)
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF98E9F0), // Color cian claro
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            shadowColor: Colors.black45,
                          ),
                          child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Link Registro
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: '¿No te has registrado? ',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Registrate',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // LADO DERECHO: IMAGEN
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1503220317375-aaad61436b1b?q=80&w=2070'), // Imagen de ejemplo de viaje
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
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