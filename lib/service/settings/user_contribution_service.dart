import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/model/user_contribution.dart';

class UserContributionService {
  final String baseUrl = 'https://poseidon-backend.fly.dev';

  Future<UserContribution> fetchUserContribution(User user) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/contribution/user/${user.userId}',
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return UserContribution.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load user contribution');
    }
  }
}
