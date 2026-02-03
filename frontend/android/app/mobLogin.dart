import 'package:flutter/material.dart';

/// Función principal del proyecto
/// Es el punto de entrada de la app
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Quita el banner de DEBUG
      debugShowCheckedModeBanner: false,

      // Pantalla inicial
      home: LoginPage(),
    );
  }
}

/// Pantalla de Login
/// Es Stateful porque tiene estado (checkbox)
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// Estado de la pantalla Login
class _LoginPageState extends State<LoginPage> {
  // Variable para el checkbox "Remember me"
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// -------------------------
          /// IMAGEN DE FONDO (AVIÓN)
          /// -------------------------
          Container(
            height: 250, // Altura de la imagen
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://media.istockphoto.com/id/1254973568/es/foto/sal%C3%B3n-de-la-terminal-del-aeropuerto-vac%C3%ADo-con-avi%C3%B3n-en-segundo-plano.jpg?s=612x612&w=0&k=20&c=jNtEZsiRA_t2RA4T3ZpF3q2LIh7c_Jnyfl-yHDp_1z8=",
                ),
                fit: BoxFit.cover, // Ajusta la imagen al contenedor
              ),
            ),
          ),

          /// -------------------------
          /// CONTENIDO PRINCIPAL (ocupa todo el resto)
          /// -------------------------
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TÍTULO
                    const Text(
                      "Hello!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    /// SUBTÍTULO
                    const Text(
                      "Secure your login with your email and password",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 25),

                    /// -------------------------
                    /// CAMPO EMAIL
                    /// -------------------------
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// -------------------------
                    /// CAMPO PASSWORD
                    /// -------------------------
                    TextField(
                      obscureText: true, // Oculta la contraseña
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// -------------------------
                    /// CHECKBOX + FORGOT PASSWORD
                    /// -------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Checkbox "Remember me"
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                // setState actualiza la pantalla
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            const Text("Remember me"),
                          ],
                        ),

                        /// Botón "Forgot password"
                        TextButton(
                          onPressed: () {
                            // Aquí irá la lógica de recuperar contraseña
                          },
                          child: const Text("Forgot the password?"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// -------------------------
                    /// BOTÓN SIGN IN
                    /// -------------------------
                    SizedBox(
                      width: double.infinity, // Ocupa todo el ancho
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Aquí irá la lógica del login
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// -------------------------
                    /// SIGN UP
                    /// -------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            // Navegar a pantalla de registro
                          },
                          child: const Text("Sign up"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}