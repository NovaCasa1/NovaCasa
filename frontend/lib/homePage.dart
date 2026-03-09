// lib/pages/homePage.dart
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  Modelo de propiedad (luego vendrá del backend)
// ─────────────────────────────────────────────
class Property {
  final String title;
  final String location;
  final String price;
  final String imageUrl;
  final int beds;
  final int baths;
  final String area;
  final bool isFeatured;

  const Property({
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.beds,
    required this.baths,
    required this.area,
    this.isFeatured = false,
  });
}

// ─────────────────────────────────────────────
//  Datos de ejemplo (reemplazar con llamadas HTTP)
// ─────────────────────────────────────────────
const _featuredProperties = [
  Property(
    title: 'Ático de Lujo',
    location: 'Madrid, Salamanca',
    price: '€ 1.250.000',
    imageUrl:
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
    beds: 4,
    baths: 3,
    area: '220 m²',
    isFeatured: true,
  ),
  Property(
    title: 'Villa con Piscina',
    location: 'Barcelona, Pedralbes',
    price: '€ 2.100.000',
    imageUrl:
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
    beds: 5,
    baths: 4,
    area: '380 m²',
    isFeatured: true,
  ),
  Property(
    title: 'Piso Moderno Centro',
    location: 'Valencia, Ruzafa',
    price: '€ 420.000',
    imageUrl:
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800',
    beds: 3,
    baths: 2,
    area: '110 m²',
    isFeatured: true,
  ),
];

const _recentProperties = [
  Property(
    title: 'Apartamento Moderno',
    location: 'Sevilla, Triana',
    price: '€ 185.000',
    imageUrl:
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600',
    beds: 2,
    baths: 1,
    area: '75 m²',
  ),
  Property(
    title: 'Casa Adosada',
    location: 'Málaga, El Limonar',
    price: '€ 310.000',
    imageUrl:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
    beds: 3,
    baths: 2,
    area: '145 m²',
  ),
  Property(
    title: 'Estudio Renovado',
    location: 'Bilbao, Casco Viejo',
    price: '€ 98.000',
    imageUrl:
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=600',
    beds: 1,
    baths: 1,
    area: '42 m²',
  ),
  Property(
    title: 'Chalet Independiente',
    location: 'Zaragoza, Las Lomas',
    price: '€ 560.000',
    imageUrl:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600',
    beds: 5,
    baths: 3,
    area: '300 m²',
  ),
];

// ─────────────────────────────────────────────
//  HomePage principal
// ─────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNav = 0;
  int _selectedFilter = 0;
  final List<String> _filters = ['Todos', 'Venta', 'Alquiler', 'Nuevos'];

  // Colores del tema — coherentes con login (azul #007BFF)
  static const _blue = Color(0xFF007BFF);
  static const _cyan = Color(0xFF98E9F0);
  static const _bg = Color(0xFFF6F9FF);
  static const _dark = Color(0xFF1A1F36);
  static const _grey = Color(0xFF8A94A6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Row(
        children: [
          // ── SIDEBAR ──────────────────────────────
          _buildSidebar(),

          // ── CONTENIDO PRINCIPAL ──────────────────
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(),
                        const SizedBox(height: 32),
                        _buildSectionHeader('Propiedades Destacadas', onSeeAll: () {}),
                        const SizedBox(height: 16),
                        _buildFeaturedCarousel(),
                        const SizedBox(height: 32),
                        _buildFilterChips(),
                        const SizedBox(height: 20),
                        _buildSectionHeader('Recién Añadidas', onSeeAll: () {}),
                        const SizedBox(height: 16),
                        _buildRecentGrid(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── SIDEBAR ────────────────────────────────────────────────────────────────
  Widget _buildSidebar() {
    const items = [
      {'icon': Icons.grid_view_rounded, 'label': 'Inicio'},
      {'icon': Icons.search_rounded, 'label': 'Buscar'},
      {'icon': Icons.favorite_border_rounded, 'label': 'Guardados'},
      {'icon': Icons.bar_chart_rounded, 'label': 'Estadísticas'},
      {'icon': Icons.message_outlined, 'label': 'Mensajes'},
    ];

    return Container(
      width: 80,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Logo
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _blue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.terrain, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 40),
          // Nav items
          ...List.generate(items.length, (i) {
            final selected = _selectedNav == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedNav = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 4),
                width: 56,
                height: 52,
                decoration: BoxDecoration(
                  color: selected ? _blue.withOpacity(0.12) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  items[i]['icon'] as IconData,
                  color: selected ? _blue : _grey,
                  size: 24,
                ),
              ),
            );
          }),
          const Spacer(),
          // Cerrar sesión
          GestureDetector(
            onTap: () => _confirmLogout(),
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              width: 56,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  // ── TOP BAR ────────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Container(
      height: 72,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Buenos días, Usuario 👋',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),
              Text(
                'Encuentra tu hogar ideal hoy',
                style: TextStyle(fontSize: 13, color: _grey),
              ),
            ],
          ),
          const Spacer(),
          // Notificaciones
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: _dark),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: _blue.withOpacity(0.15),
            child: const Icon(Icons.person, color: _blue, size: 22),
          ),
        ],
      ),
    );
  }

  // ── BARRA DE BÚSQUEDA ──────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search_rounded, color: _grey),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Busca por ciudad, zona, precio...',
                hintStyle: TextStyle(color: _grey, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: _blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Buscar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── ENCABEZADO DE SECCIÓN ──────────────────────────────────────────────────
  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'Ver todo',
            style: TextStyle(
              color: _blue,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  // ── CARRUSEL DESTACADOS ────────────────────────────────────────────────────
  Widget _buildFeaturedCarousel() {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _featuredProperties.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (_, i) => _FeaturedCard(property: _featuredProperties[i]),
      ),
    );
  }

  // ── CHIPS DE FILTRO ────────────────────────────────────────────────────────
  Widget _buildFilterChips() {
    return Row(
      children: List.generate(_filters.length, (i) {
        final selected = _selectedFilter == i;
        return GestureDetector(
          onTap: () => setState(() => _selectedFilter = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? _blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: selected
                  ? [BoxShadow(color: _blue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))]
                  : [],
            ),
            child: Text(
              _filters[i],
              style: TextStyle(
                color: selected ? Colors.white : _grey,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        );
      }),
    );
  }

  // ── CUADRÍCULA RECIENTES ───────────────────────────────────────────────────
  Widget _buildRecentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        childAspectRatio: 0.85,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: _recentProperties.length,
      itemBuilder: (_, i) => _RecentCard(property: _recentProperties[i]),
    );
  }

  // ── DIÁLOGO CERRAR SESIÓN ──────────────────────────────────────────────────
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que quieres salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // cerrar dialog
              Navigator.of(context).pop(); // volver al login
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Salir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Tarjeta — Propiedad Destacada
// ─────────────────────────────────────────────
class _FeaturedCard extends StatefulWidget {
  final Property property;
  const _FeaturedCard({required this.property});

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    return Container(
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(p.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge + Favorito
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007BFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'DESTACADO',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _saved = !_saved),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _saved ? Icons.favorite : Icons.favorite_border,
                      color: _saved ? Colors.redAccent : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Info inferior
            Text(
              p.title,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 14),
                const SizedBox(width: 4),
                Text(p.location, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _InfoBadge(icon: Icons.bed_outlined, label: '${p.beds} hab'),
                const SizedBox(width: 8),
                _InfoBadge(icon: Icons.bathtub_outlined, label: '${p.baths} baños'),
                const SizedBox(width: 8),
                _InfoBadge(icon: Icons.straighten, label: p.area),
                const Spacer(),
                Text(
                  p.price,
                  style: const TextStyle(color: Color(0xFF98E9F0), fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Tarjeta — Propiedad Reciente
// ─────────────────────────────────────────────
class _RecentCard extends StatefulWidget {
  final Property property;
  const _RecentCard({required this.property});

  @override
  State<_RecentCard> createState() => _RecentCardState();
}

class _RecentCardState extends State<_RecentCard> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(p.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => setState(() => _saved = !_saved),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)
                        ],
                      ),
                      child: Icon(
                        _saved ? Icons.favorite : Icons.favorite_border,
                        color: _saved ? Colors.redAccent : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1A1F36),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF8A94A6), size: 13),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        p.location,
                        style: const TextStyle(color: Color(0xFF8A94A6), fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _SmallBadge(icon: Icons.bed_outlined, label: '${p.beds}'),
                    const SizedBox(width: 6),
                    _SmallBadge(icon: Icons.bathtub_outlined, label: '${p.baths}'),
                    const SizedBox(width: 6),
                    _SmallBadge(icon: Icons.straighten, label: p.area),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  p.price,
                  style: const TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Widgets auxiliares pequeños
// ─────────────────────────────────────────────
class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }
}

class _SmallBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SmallBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF8A94A6), size: 13),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(color: Color(0xFF8A94A6), fontSize: 12)),
      ],
    );
  }
}