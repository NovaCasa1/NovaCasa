// lib/models/user_model.dart
// ─────────────────────────────────────────────────────────────────────────────
// MODELO DE USUARIO
// Representa los datos del usuario que vienen del backend tras login/register.
// Se usa en toda la app para pasar el usuario entre páginas.
// ─────────────────────────────────────────────────────────────────────────────

class UserModel {
  // ── CAMPOS ──────────────────────────────────────────────────────────────────
  final String id;        // ID único del usuario en la base de datos
  final String name;      // Nombre (se muestra en el saludo de HomePage)
  final String surname;   // Apellido
  final String email;     // Email (se usa para login)
  final String telephone; // Teléfono
  final String? photoUrl; // Foto de perfil (opcional, puede ser null)

  // ── CONSTRUCTOR ─────────────────────────────────────────────────────────────
  // Si quieres añadir más campos (ej: countryId), añádelos aquí
  const UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.telephone,
    this.photoUrl, // opcional
  });

  // ── fromJson ─────────────────────────────────────────────────────────────────
  // Convierte la respuesta JSON del backend en un objeto UserModel.
  // Se llama así: final user = UserModel.fromJson(data['user']);
  // Si el backend añade más campos, agrégalos aquí también.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:        json['id']        as String,
      name:      json['name']      as String,
      surname:   json['surname']   as String? ?? '',  // por si viene vacío
      email:     json['email']     as String,
      telephone: json['telephone'] as String? ?? '',  // por si viene vacío
      photoUrl:  json['photoUrl']  as String?,        // puede ser null
    );
  }

  // ── toJson ───────────────────────────────────────────────────────────────────
  // Convierte el objeto a JSON. Útil si necesitas guardarlo localmente
  // (SharedPreferences, etc.) para mantener la sesión.
  Map<String, dynamic> toJson() {
    return {
      'id':        id,
      'name':      name,
      'surname':   surname,
      'email':     email,
      'telephone': telephone,
      'photoUrl':  photoUrl,
    };
  }
}