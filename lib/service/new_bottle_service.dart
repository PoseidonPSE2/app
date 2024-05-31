import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_worl2/model/bottle.dart';

class NewBottleService {
  static String baseUrl = 'https://poseidon-backend.fly.dev/bottles';

  static Future<void> postNewBottle(Bottle bottle) async {
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
}
