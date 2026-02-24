import 'package:flutter/material.dart';

class MobAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showLogo;
  final bool centerTitle;
  final VoidCallback? onLanguagePressed;

  const MobAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showLogo = true,
    this.centerTitle = true,
    this.onLanguagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[800],
      elevation: 4,
      centerTitle: centerTitle,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: centerTitle
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (showLogo)
            Image.asset(
              "assets/icons/logo-NovaCasa.png",
              height: 28,
              color: Colors.white,
            ),
          if (showLogo) const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        if (onLanguagePressed != null)
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: onLanguagePressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}