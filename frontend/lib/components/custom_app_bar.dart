import 'package:flutter/material.dart';
import '../pages/serviciosPage.dart';
import '../pages/homePage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A8FE3),
      elevation: 2,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            // Logo a la izquierda
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WebLoginPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(
                  'assets/icons/logo-NovaCasa.png',
                  height: 84,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Spacer(),
            // Items de navegación a la derecha
            _NavItem(label: 'Inicio', onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WebLoginPage(),
                ),
              );
            }),
            const SizedBox(width: 32),
            _NavItem(label: 'Acerca de', onPressed: () {}),
            const SizedBox(width: 32),
            _NavItem(label: 'Servicios', onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ServiciosPage(),
                ),
              );
            }),
            const SizedBox(width: 32),
            _NavItem(label: 'Contacto', onPressed: () {}),
            const SizedBox(width: 48),
            // Botones a la derecha
            _OutlineButton(
              label: 'Inicio Sesión',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WebLoginPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            _OutlineButton(
              label: 'Registrarse',
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _NavItem({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _OutlineButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}