import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // En Docker el backend corre en localhost:3000
  // En emulador Android usar 10.0.2.2:3000
  static const String _baseUrl = 'http://localhost:3000/api';

  // ─── EMPLEOS ────────────────────────────────────────────────────────────────

  static Future<List<Map<String, dynamic>>> getEmpleos() async {
    final response = await http.get(Uri.parse('$_baseUrl/jobs'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception('Error al cargar empleos: ${response.statusCode}');
  }

  // ─── VIVIENDAS ───────────────────────────────────────────────────────────────

  static Future<List<Map<String, dynamic>>> getViviendas() async {
    final response = await http.get(Uri.parse('$_baseUrl/dwellings'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception('Error al cargar viviendas: ${response.statusCode}');
  }

  // ─── SCRAPING (llamar una sola vez para poblar la BD) ───────────────────────

  static Future<Map<String, dynamic>> triggerScrapeAll() async {
    final response = await http.post(Uri.parse('$_baseUrl/scrape/all'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Error en scraping: ${response.statusCode}');
  }

  static Future<Map<String, dynamic>> triggerScrapeJobs() async {
    final response = await http.post(Uri.parse('$_baseUrl/scrape/jobs'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Error en scraping empleos: ${response.statusCode}');
  }

  static Future<Map<String, dynamic>> triggerScrapeDwellings() async {
    final response = await http.post(Uri.parse('$_baseUrl/scrape/dwellings'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Error en scraping viviendas: ${response.statusCode}');
  }
}
