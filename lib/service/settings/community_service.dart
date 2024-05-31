import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunityService {
  final String baseUrl = 'https://poseidon-backend.fly.dev';

  Future<Map<String, dynamic>> fetchCommunityContribution() async {
    final response =
        await http.get(Uri.parse('$baseUrl/contribution/community'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load community contribution data');
    }
  }
}
