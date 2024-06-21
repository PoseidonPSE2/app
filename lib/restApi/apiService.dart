import 'dart:convert';

import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/model/refillstation.dart';

import 'package:http/http.dart' as http;

import 'package:hello_worl2/restApi/mapper.dart';

class ApiService {
  // static final config = loadYaml('config.yaml');
  // static final String _baseUrl = config['server_url'];
  final String _baseUrl = "https://poseidon-backend.fly.dev";

  Future<List<RefillStationMarker>> getAllRefillMarker() async {
    String url = "$_baseUrl/refill_stations/markers";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody
          .map((station) => RefillStationMarker.fromJson(station))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch refill stations: ${response.statusCode}');
    }
  }

  Future<RefillStation> getRefillstationById(int refillstationId) async {
    String url = "$_baseUrl/refill_stations/$refillstationId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print(jsonBody);
      return RefillStation.fromJson(jsonBody);
    } else {
      throw Exception(
          'Failed to fetch refill station with id: ${response.statusCode}');
    }
  }

  Future<RefillstationReviewAverage> getRefillStationReviewAverage(
      int refillstationId) async {
    String url = "$_baseUrl/refill_stations/$refillstationId/reviews";
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return RefillstationReviewAverage.fromJson(jsonBody);
    }
    if (response.statusCode == 404) {
      final jsonBody = jsonDecode(response.body);

      RefillstationReviewAverage average = jsonBody
          .map((item) => RefillstationReviewAverage.fromJson(item))
          .toList();
      return average;
    } else {
      throw Exception(
          'Failed to fetch refill station review average: ${response.statusCode}');
    }
  }

  Future<RefillstationReview> getRefillstationReviewByUserId(
      int refillstationId, int stationId) async {
    String url = "$_baseUrl/refill_station_reviews/$refillstationId/$stationId";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody.isNotEmpty) {
        return RefillstationReview.fromJson(jsonBody);
      } else {
        // Return a default review if no review is found
        return RefillstationReview(
            cleanness: 0,
            accessibility: 0,
            water_quality: 0,
            station_id: stationId,
            user_id: refillstationId);
      }
    } else {
      throw Exception(
          'Failed to fetch refill station review with id: ${response.statusCode}');
    }
  }

  void postRefillstationReview(RefillstationReview review) async {
    var body = jsonEncode(review);
    print("test2:" + body);
    Uri uri = Uri.parse("$_baseUrl/refill_station_reviews");
    final response = await http.post(
      uri,
      body: body,
    );
    print("test" + response.body);
  }

  void postRefillstationProblem(RefillstationProblem problem) async {
    var body = jsonEncode(problem);
    // var body = problem.toJson();

    Uri uri = Uri.parse("$_baseUrl/refill_station_problems");
    final response = await http.post(
      uri,
      body: body,
    );
  }

  Future<int> getLikeCounterForStation(int stationId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/likes/$stationId/count'));
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['like_counter'];
    } else {
      throw Exception('Failed to load likes');
    }
  }

  Future<bool> getLike(int stationId, int userId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/likes/$stationId/$userId"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Like is: ${data['isLiked']}');
      return data['isLiked'];
    } else {
      print('Failed to post like: ${response.statusCode}');
      return false; // Rückgabe von `false` im Fehlerfall
    }
  }

  Future<void> postLike(int stationId, int userId) async {
    final like = RefillstationLike(stationId: stationId, userId: userId);
    String body = json.encode(like.toJson());
    final response = await http.post(
      Uri.parse("$_baseUrl/likes"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      final data = json.decode(response.body);
      print('Like posted successfully: $data');
    } else {
      print('Failed to post like: ${response.statusCode}');
    }
  }

  Future<void> deleteLike(int stationId, int userId) async {
    final like = RefillstationLike(stationId: stationId, userId: userId);
    String body = json.encode(like.toJson());
    final response = await http.delete(
      Uri.parse("$_baseUrl/likes"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Like posted successfully: $data');
    } else {
      print('Failed to post like: ${response.statusCode}');
    }
  }

  Future<List<ContributionKL>> getContributionKL() async {
    String url = "$_baseUrl/getContributionKL";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody
          .map((station) => ContributionKL.fromJson(station))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch contribution KL: ${response.statusCode}');
    }
  }

  Future<List<Contribution>> getContributionCommunity() async {
    String url = "$_baseUrl/getContributionCommunity";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody.map((station) => Contribution.fromJson(station)).toList();
    } else {
      throw Exception(
          'Failed to fetch contribution community: ${response.statusCode}');
    }
  }

  Future<List<Contribution>> getContributionByUser(int userId) async {
    String url = "$_baseUrl/getContributionByUser/$userId";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody.map((station) => Contribution.fromJson(station)).toList();
    } else {
      throw Exception(
          'Failed to fetch contribution from user: ${response.statusCode}');
    }
  }

  Future<List<ConsumerTestQuestion>> getConsumerTestQuestion() async {
    String url = "$_baseUrl/getConsumerTestQuestion";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody
          .map((station) => ConsumerTestQuestion.fromJson(station))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch consumer test question: ${response.statusCode}');
    }
  }

  void postConsumerTestAnswer(ConsumerTestAnswer testAnswer) async {
    String body = json.encode(testAnswer);
    final response = await http.post(
      Uri.parse("$_baseUrl/postConsumerTestAnswer"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
    } else {}
  }

  Future<List<ConsumerTestAverage>> getConsumerTestAverage() async {
    String url = "$_baseUrl/getConsumerTestAverage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody
          .map((station) => ConsumerTestAverage.fromJson(station))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch consumer test average: ${response.statusCode}');
    }
  }

  Future<List<Bottle>> getAllBottlesByUser(int userId) async {
    String url = "$_baseUrl/getAllBottlesByUser/$userId";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody.map((station) => Bottle.fromJson(station)).toList();
    } else {
      throw Exception(
          'Failed to fetch bottle by user id: ${response.statusCode}');
    }
  }

  void postNewBottle(Bottle bottle) async {
    String body = json.encode(bottle);
    final response = await http.post(
      Uri.parse("$_baseUrl/postNewBottle"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
    } else {}
  }

  void postEditBottle(Bottle bottle) async {
    String body = json.encode(bottle);
    final response = await http.post(
      Uri.parse("$_baseUrl/postEditBottle"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
    } else {}
  }
}
