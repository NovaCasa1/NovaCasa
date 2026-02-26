import 'package:flutter/material.dart';
import 'register_page.dart';
import 'apptheme.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          height: AppTheme.cardHeight,
          width: AppTheme.cardWidth,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            children: [
              // LADO IZQUIERDO: FORMULARIO AZUL
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.formPaddingH,
                    vertical: AppTheme.formPaddingV,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardRadius),
                      bottomLeft: Radius.circular(AppTheme.cardRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo NovaCasa
                      Row(
                        children: [
                          const Icon(
                            Icons.terrain,
                            color: AppTheme.white,
                            size: AppTheme.logoIconSize,
                          ),
                          const SizedBox(width: 8),
                          Text('NovaCasa', style: AppTheme.logoText),
                        ],
                      ),

                      const SizedBox(height: 40),

                      Text('Iniciar Sesión', style: AppTheme.titleText),
                      Text(
                        'Bienvenido, por favor introduce tus credenciales',
                        style: AppTheme.subtitleText,
                      ),

                      const SizedBox(height: 30),

                      // Email
                      Text('Email', style: AppTheme.labelText),
                      const SizedBox(height: 8),
                      AppTextField(_emailController, 'Introduce tu email'),

                      const SizedBox(height: 20),

                      // Contraseña
                      Text('Contraseña', style: AppTheme.labelText),
                      const SizedBox(height: 8),
                      AppTextField(_passwordController, '••••••••',
                          isPassword: true),

                      // Checkbox Recordar
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) =>
                                setState(() => _rememberMe = value ?? false),
                            activeColor: AppTheme.white,
                            checkColor: AppTheme.primaryBlue,
                          ),
                          const Text(
                            'Recordarme',
                            style: TextStyle(color: AppTheme.white, fontSize: 12),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Botón Continuar
                      SizedBox(
                        width: double.infinity,
                        height: AppTheme.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentCyan,
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.fieldRadius),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black45,
                          ),
                          child: const Text('Continuar',
                              style: AppTheme.buttonText),
                        ),
                      ),

                      const Spacer(),

                      // Link Registro
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RegisterPage()),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: '¿No tienes cuenta? ',
                              style: AppTheme.linkText,
                              children: [
                                TextSpan(
                                    text: 'Regístrate',
                                    style: AppTheme.linkBoldText),
                              ],
                            ),
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
                child: ImagePanel(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppTheme.cardRadius),
                    bottomRight: Radius.circular(AppTheme.cardRadius),
                  ),
                  gradientBegin: Alignment.centerLeft,
                  gradientEnd: Alignment.centerRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}