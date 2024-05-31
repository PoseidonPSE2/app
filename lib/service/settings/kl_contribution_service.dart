import 'dart:convert';
import 'package:http/http.dart' as http;

class KLContributionService {
  final String baseUrl = 'https://poseidon-backend.fly.dev';

  Future<Map<String, dynamic>> fetchKLContribution() async {
    final response = await http.get(Uri.parse('$baseUrl/contribution/kl'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fehler die Kaiserslautern daten zu holen');
    }
  }
}
