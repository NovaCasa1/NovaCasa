import 'package:flutter/material.dart';

class AppTheme {
  static const Color white = Colors.white;
  static const Color primaryBlue = Color(0xFF007BFF);
  static const Color accentCyan = Color(0xFF98E9F0);
  static const double cardHeight = 550;
  static const double cardWidth = 900;
  static const double cardRadius = 40;
  static const double formPaddingH = 40;
  static const double formPaddingV = 30;
  static const double logoIconSize = 72;
  static const double buttonHeight = 45;
  static const double fieldRadius = 10;

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      spreadRadius: 5,
    ),
  ];

  static const TextStyle logoText = TextStyle(
    color: white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleText = TextStyle(
    color: white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitleText = TextStyle(
    color: Colors.white70,
    fontSize: 13,
  );
  static const TextStyle labelText = TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static const TextStyle linkText = TextStyle(
    color: Colors.white70,
    fontSize: 12,
  );
  static const TextStyle linkBoldText = TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  const AppTextField(this.controller, this.hint, {super.key, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.fieldRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

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
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.transparent,
            ],
            begin: gradientBegin,
            end: gradientEnd,
          ),
        ),
      ),
    );
  }
}