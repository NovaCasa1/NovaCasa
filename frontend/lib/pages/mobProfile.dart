import 'package:flutter/material.dart';

class MobProfile extends StatelessWidget {
  const MobProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Hero header ──────────────────────────────────────────────
          _buildProfileHeader(),
          const SizedBox(height: 24),

          // ── Info cards ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Información personal",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),
                _infoCard(
                  children: [
                    _infoRow(Icons.email_rounded, "Correo", "usuario@novacasa.es"),
                    _divider(),
                    _infoRow(Icons.phone_rounded, "Teléfono", "+34 612 345 678"),
                    _divider(),
                    _infoRow(Icons.location_on_rounded, "Ubicación", "Madrid, España"),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Cuenta",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),
                _infoCard(
                  children: [
                    _actionRow(
                      icon: Icons.bookmark_rounded,
                      color: const Color(0xFF1565C0),
                      label: "Guardados",
                      onTap: () {},
                    ),
                    _divider(),
                    _actionRow(
                      icon: Icons.history_rounded,
                      color: const Color(0xFF2E7D32),
                      label: "Historial de búsquedas",
                      onTap: () {},
                    ),
                    _divider(),
                    _actionRow(
                      icon: Icons.notifications_rounded,
                      color: const Color(0xFF6A1B9A),
                      label: "Notificaciones",
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Soporte",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),
                _infoCard(
                  children: [
                    _actionRow(
                      icon: Icons.help_rounded,
                      color: const Color(0xFF0097A7),
                      label: "Ponerse en contacto",
                      onTap: () {},
                    ),
                    _divider(),
                    _actionRow(
                      icon: Icons.privacy_tip_rounded,
                      color: const Color(0xFF455A64),
                      label: "Política de privacidad",
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Botón cerrar sesión ──────────────────────────────
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_rounded,
                            color: Colors.red.shade400, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          "Cerrar sesión",
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header con avatar ────────────────────────────────────────────────────

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Avatar con badge de edición
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 44,
                  backgroundColor: Color(0xFF42A5F5),
                  child: Icon(Icons.person, color: Colors.white, size: 48),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF42A5F5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Nombre Usuario",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "usuario@novacasa.es",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statChip(Icons.home_rounded, "3", "Viviendas"),
              _statDivider(),
              _statChip(Icons.work_rounded, "5", "Empleos"),
              _statDivider(),
              _statChip(Icons.assignment_rounded, "2", "Trámites"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _statDivider() {
    return Container(
      height: 32,
      width: 1,
      color: Colors.white.withOpacity(0.15),
    );
  }

  // ── Card contenedor ──────────────────────────────────────────────────────

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // ── Fila de dato informativo ─────────────────────────────────────────────

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E).withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF1A1A2E)),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Fila de acción con flecha ────────────────────────────────────────────

  Widget _actionRow({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      indent: 18,
      endIndent: 18,
      color: Colors.grey.shade100,
    );
  }
}