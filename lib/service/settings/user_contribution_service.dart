import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/model/user_contribution.dart';

class UserContributionService {
  final String baseUrl = 'https://poseidon-backend.fly.dev';

  Future<UserContribution> fetchUserContribution(User user) async {
    final url = Uri.https(
      'poseidon-backend.fly.dev',
      '/contribution/user',
      {'userId': '${user.userId}'},
    );

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return UserContribution.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load user contribution');
    }
  }
}
