import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_worl2/model/bottle.dart';

class NewBottleService {
  static String baseUrl = 'https://poseidon-backend.fly.dev/bottles';

  Future<void> postNewBottle(Bottle bottle) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bottle.toJson()),
    );

    print(bottle.toJson());
    if (response.statusCode == 201) {
      print('New bottle created successfully');
    } else {
      print(response.statusCode);
      throw Exception('Failed to create new bottle');
    }
  }

  Future<void> deleteBottle(int bottleId) async {
    final url =
        Uri.https('poseidon-backend.fly.dev', '/bottles', {'id': '$bottleId'});

    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Bottle deleted successfully");
    } else {
      throw Exception('Failed to delete bottle');
    }
  }

  Future<List<Bottle>> fetchUserBottles(int userId) async {
    final url = '$baseUrl/users/$userId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("Raw JSON response: $data");

      List<Bottle> bottles = data.map((item) => Bottle.fromJson(item)).toList();
      return bottles;
    } else {
      throw Exception('Failed to load bottles');
    }
  }
}
