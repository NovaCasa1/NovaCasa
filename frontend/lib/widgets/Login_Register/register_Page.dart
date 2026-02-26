import 'package:flutter/material.dart';
import 'login_page.dart';
import 'apptheme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0.08, 0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
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
                  // LADO IZQUIERDO: IMAGEN
                  Expanded(
                    flex: 5,
                    child: ImagePanel(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppTheme.cardRadius),
                        bottomLeft: Radius.circular(AppTheme.cardRadius),
                      ),
                      gradientBegin: Alignment.centerRight,
                      gradientEnd: Alignment.centerLeft,
                    ),
                  ),

                  // LADO DERECHO: FORMULARIO AZUL
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.formPaddingH,
                        vertical: 22, // ✅ Reducido de 30 → 22
                      ),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppTheme.cardRadius),
                          bottomRight: Radius.circular(AppTheme.cardRadius),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo NovaCasa
                          Row(
                            children: [
                              const Icon(Icons.terrain,
                                  color: AppTheme.white,
                                  size: AppTheme.logoIconSize),
                              const SizedBox(width: 8),
                              Text('NovaCasa', style: AppTheme.logoText),
                            ],
                          ),

                          const SizedBox(height: 20), // ✅ Reducido de 36 → 20

                          Text('Registro', style: AppTheme.titleText),
                          const SizedBox(height: 4), // ✅ Reducido de 6 → 4
                          Text(
                            'Bienvenido, por favor introduce tus datos',
                            style: AppTheme.subtitleText,
                          ),

                          const SizedBox(height: 18), // ✅ Reducido de 28 → 18

                          // Nombre
                          Text('Nombre', style: AppTheme.labelText),
                          const SizedBox(height: 6), // ✅ Reducido de 8 → 6
                          AppTextField(_nameController, 'Introduce tu nombre'),

                          const SizedBox(height: 12), // ✅ Reducido de 18 → 12

                          // Email
                          Text('Email', style: AppTheme.labelText),
                          const SizedBox(height: 6),
                          AppTextField(_emailController, 'Introduce tu email'),

                          const SizedBox(height: 12),

                          // Contraseña
                          Text('Contraseña', style: AppTheme.labelText),
                          const SizedBox(height: 6),
                          AppTextField(_passwordController, '••••••••',
                              isPassword: true),

                          const SizedBox(height: 16), // ✅ Reducido de 22 → 16

                          // Botón
                          SizedBox(
                            width: double.infinity,
                            height: AppTheme.buttonHeight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.accentCyan,
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.fieldRadius),
                                ),
                                elevation: 6,
                                shadowColor: Colors.black38,
                              ),
                              child: const Text('Registrarse',
                                  style: AppTheme.buttonText),
                            ),
                          ),

                          const Spacer(),

                          // Link Login
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: '¿Ya tienes cuenta? ',
                                  style: AppTheme.linkText,
                                  children: [
                                    TextSpan(
                                      text: 'Inicia sesión',
                                      style: AppTheme.linkBoldText,
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}