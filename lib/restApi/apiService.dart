import 'dart:convert';

import 'package:flutter/physics.dart';

import 'package:hello_worl2/model/bottle.dart';

import 'package:http/http.dart' as http;

import 'package:hello_worl2/restApi/mapper.dart';
import 'package:yaml/yaml.dart';

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

  Future<List<RefillstationReview>> getRefillstationReview(
      int refillstationId) async {
    String url = "$_baseUrl/getRefillstationReview/$refillstationId";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody
          .map((station) => RefillstationReview.fromJson(station))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch refill station review with id: ${response.statusCode}');
    }
  }

  void postRefillstationReview(RefillstationReview review) async {
    var body = jsonEncode(review);
    Uri uri = Uri.parse("$_baseUrl/refill_station_reviews");
    final response = await http.post(
      uri,
      body: body,
    );
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

  Future<List<RefillstationLike>> getRefillstationLike() async {
    String url = "$_baseUrl/getRefillstationLike";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List<dynamic>;
      return jsonBody
          .map((station) => RefillstationLike.fromJson(station))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch refill station like: ${response.statusCode}');
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

  void postRefillstationLike(RefillstationLike like) async {
    String body = json.encode(like);
    final response = await http.post(
      Uri.parse("$_baseUrl/postRefillstationLike"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
    } else {}
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
