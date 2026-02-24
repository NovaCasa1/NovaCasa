import 'package:flutter/material.dart';

/// Pantalla de Login con controladores y seguridad de contraseña
class MobLoginPage extends StatefulWidget {
  const MobLoginPage({super.key});

  @override
  State<MobLoginPage> createState() => _MobLoginPageState();
}

class _MobLoginPageState extends State<MobLoginPage> {
  // Controladores
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Estado del checkbox y visibilidad de contraseña
  bool rememberMe = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ================= FOTO DE FONDO (TUYA)
          Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://media.istockphoto.com/id/1254973568/es/foto/sal%C3%B3n-de-la-terminal-del-aeropuerto-vac%C3%ADo-con-avi%C3%B3n-en-segundo-plano.jpg?s=612x612&w=0&k=20&c=jNtEZsiRA_t2RA4T3ZpF3q2LIh7c_Jnyfl-yHDp_1z8=",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // ================= CONTENIDO ORIGINAL
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Secure your login with your email and password",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 25),

                        // Campo Email
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
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

                        // Campo Password
                        TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Checkbox + Forgot password
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  },
                                ),
                                const Text("Remember me"),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child:
                                  const Text("Forgot the password?"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Botón Sign In
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              String email =
                                  emailController.text.trim();
                              String password =
                                  passwordController.text.trim();

                              if (email.isEmpty ||
                                  password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please enter both email and password",
                                    ),
                                  ),
                                );
                                return;
                              }

                              print("Email: $email");
                              print("Password: $password");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign Up
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                                "Don't have an account? "),
                            TextButton(
                              onPressed: () {},
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

          // ================= LOGO CENTRADO ARRIBA
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/icons/logo-NovaCasa.png",
                height: 180,
              ),
            ),
          ),

          // ================= BOTÓN IDIOMA ARRIBA DERECHA
          Positioned(
            top: 40,
            right: 15,
            child: IconButton(
              icon: const Icon(Icons.language, color: Colors.blue),
              onPressed: () {
                // TODO: cambiar idioma
              },
            ),
          ),
        ],
      ),
    );
  }
}