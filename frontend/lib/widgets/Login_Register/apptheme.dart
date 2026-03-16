// lib/widgets/app_theme.dart
// ─────────────────────────────────────────────────────────────────────────────
// TEMA Y COMPONENTES REUTILIZABLES
// Aquí están todos los colores, tamaños y estilos de texto del proyecto.
// Si quieres cambiar el diseño global, modifica solo este archivo.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class AppTheme {
  // ── COLORES ──────────────────────────────────────────────────────────────────
  // Para cambiar el color principal de la app, cambia primaryBlue
  static const Color white       = Colors.white;
  static const Color primaryBlue = Color(0xFF007BFF); // azul principal
  static const Color accentCyan  = Color(0xFF98E9F0); // cian de botones

  // ── TAMAÑOS DE LA TARJETA LOGIN/REGISTER ─────────────────────────────────────
  // Si la tarjeta no cabe en pantalla, ajusta cardHeight y cardWidth
  static const double cardHeight  = 550;
  static const double cardWidth   = 900;
  static const double cardRadius  = 40;  // redondez de las esquinas
  static const double formPaddingH = 40; // padding horizontal del formulario
  static const double formPaddingV = 30; // padding vertical del formulario
  static const double logoIconSize = 72;
  static const double buttonHeight = 45; // altura de los botones
  static const double fieldRadius  = 10; // redondez de los campos de texto

  // ── SOMBRAS ───────────────────────────────────────────────────────────────────
  // Sombra de la tarjeta principal — cambia la opacidad para más/menos sombra
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      spreadRadius: 5,
    ),
  ];

  // ── ESTILOS DE TEXTO ──────────────────────────────────────────────────────────
  // logoText   → "NovaCasa" en la esquina superior
  // titleText  → "Iniciar Sesión" / "Crear Cuenta"
  // subtitleText → texto pequeño debajo del título
  // labelText  → etiquetas de los campos (Email, Contraseña...)
  // buttonText → texto dentro de los botones
  // linkText   → "¿No te has registrado?"
  // linkBoldText → "Registrate" (subrayado y negrita)
  static const TextStyle logoText     = TextStyle(color: white, fontSize: 22, fontWeight: FontWeight.bold);
  static const TextStyle titleText    = TextStyle(color: white, fontSize: 28, fontWeight: FontWeight.bold);
  static const TextStyle subtitleText = TextStyle(color: Colors.white70, fontSize: 13);
  static const TextStyle labelText    = TextStyle(color: white, fontWeight: FontWeight.bold);
  static const TextStyle buttonText   = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle linkText     = TextStyle(color: Colors.white70, fontSize: 12);
  static const TextStyle linkBoldText = TextStyle(
    color: white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline);
}

// ─────────────────────────────────────────────────────────────────────────────
// CAMPO DE TEXTO REUTILIZABLE
// Úsalo así: AppTextField(controller, 'Introduce el email')
// Para contraseña: AppTextField(controller, '', isPassword: true)
// ─────────────────────────────────────────────────────────────────────────────
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword; // true → oculta el texto (contraseñas)

  const AppTextField(this.controller, this.hint, {super.key, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.fieldRadius),
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

// ─────────────────────────────────────────────────────────────────────────────
// PANEL DE IMAGEN (lado derecho en login, lado izquierdo en register)
// borderRadius → redondea las esquinas del lado correcto
// gradientBegin/End → dirección del degradado azul sobre la imagen
// Para cambiar la imagen, modifica el NetworkImage de abajo
// ─────────────────────────────────────────────────────────────────────────────
class ImagePanel extends StatelessWidget {
  final BorderRadius borderRadius;
  final Alignment gradientBegin;
  final Alignment gradientEnd;

  const ImagePanel({
    super.key,
    required this.borderRadius,
    required this.gradientBegin,
    required this.gradientEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: const DecorationImage(
          // ← CAMBIA ESTA URL para usar otra imagen de fondo
          image: NetworkImage(
            'https://images.unsplash.com/photo-1503220317375-aaad61436b1b?q=80&w=2070',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
            begin: gradientBegin,
            end: gradientEnd,
          ),
        ),
      ),
    );
  }
}