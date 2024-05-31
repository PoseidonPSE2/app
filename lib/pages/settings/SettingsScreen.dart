import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'https://poseidon-backend.fly.dev';

  Future<List> fetchUserIds() async {
    final response = await http.get(Uri.parse('$baseUrl/refill_stations'));

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService userService = UserService();
  Future<List>? futureUserIds;

  void _fetchUserIds() {
    setState(() {
      futureUserIds = userService.fetchUserIds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User IDs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _fetchUserIds,
              child: Text('Fetch User IDs'),
            ),
            SizedBox(height: 20),
            FutureBuilder<List>(
              future: futureUserIds,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No user IDs found');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('User ID: ${snapshot.data![index]}'),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
