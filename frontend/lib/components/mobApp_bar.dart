import 'package:flutter/material.dart';

class MobAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Image.asset(
            "assets/icons/logo-NovaCasa.png",
            height: 60,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 15),
          child: IconButton(
            icon: const Icon(Icons.language, color: Colors.blue),
            onPressed: () {
              // Lógica para cambiar idioma
            },
          ),
        ),
      ],
    );
  }
}
