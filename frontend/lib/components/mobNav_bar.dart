import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MobNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: "Home"),
    _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: "Perfil"),
    _NavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings_rounded, label: "Ajustes"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _items.length,
              (index) => _NavBarItem(
                item: _items[index],
                isActive: currentIndex == index,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Modelo ───────────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// ─── Item individual ──────────────────────────────────────────────────────────

class _NavBarItem extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.85,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _controller.reverse();
  void _onTapUp(_) {
    _controller.forward();
    widget.onTap();
  }
  void _onTapCancel() => _controller.forward();

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isActive;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: isActive ? 18 : 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: isActive
                ? Border.all(color: Colors.white.withOpacity(0.15), width: 1)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? widget.item.activeIcon : widget.item.icon,
                color: isActive ? Colors.white : Colors.white38,
                size: 24,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                child: isActive
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          widget.item.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 0.3,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}