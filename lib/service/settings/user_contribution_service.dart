import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_worl2/model/user.dart';

class UserContributionService {
  final String baseUrl = 'https://poseidon-backend.fly.dev';

  Future<Map<String, dynamic>> fetchUserContribution(User user) async {
    final userId = user.userId;
    if (userId == null) {
      throw ArgumentError('User ID is null');
    }

    final response =
        await http.get(Uri.parse('$baseUrl/contribution/user?userId=$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user contribution');
    }
  }
}
