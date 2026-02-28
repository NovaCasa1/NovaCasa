import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showLogo;
  final bool centerTitle;
  final VoidCallback? onLanguagePressed;
  final List<Widget>? extraActions;
  final Color? backgroundColor;
  final bool transparent;

  const MobAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showLogo = true,
    this.centerTitle = true,
    this.onLanguagePressed,
    this.extraActions,
    this.backgroundColor,
    this.transparent = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBg = transparent
        ? Colors.transparent
        : (backgroundColor ?? const Color(0xFF1565C0));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Container(
        decoration: transparent
            ? null
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    backgroundColor ?? const Color(0xFF1A1A2E),
                    backgroundColor?.withBlue(200) ?? const Color(0xFF16213E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: centerTitle,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: showBackButton
              ? _BackButton()
              : null,
          title: _AppBarTitle(
            title: title,
            showLogo: showLogo,
            centerTitle: centerTitle,
          ),
          actions: [
            if (onLanguagePressed != null)
              _AppBarIconButton(
                icon: Icons.language_rounded,
                onPressed: onLanguagePressed!,
                tooltip: "Idioma",
              ),
            if (extraActions != null) ...extraActions!,
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ─── Subwidgets privados ───────────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final String title;
  final bool showLogo;
  final bool centerTitle;

  const _AppBarTitle({
    required this.title,
    required this.showLogo,
    required this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (showLogo) ...[
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              "assets/icons/logo-NovaCasa.png",
              height: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
        ],
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  const _AppBarIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Material(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}