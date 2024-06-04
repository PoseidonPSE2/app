import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/service/new_bottle_service.dart';

class BottleProvider extends ChangeNotifier {
  List<Bottle> _bottles = [];
  bool _isLoading = false;

  List<Bottle> get bottles => _bottles;
  bool get isLoading => _isLoading;

  final NewBottleService _bottleService = NewBottleService();

  BottleProvider();

  Future<void> fetchBottles(User userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _bottles = await _bottleService.fetchUserBottles(userId.userId);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBottle(Bottle bottle) async {
    await NewBottleService.postNewBottle(bottle);
    notifyListeners();
  }

  void removeBottle(int bottleId) async {
    final index = _bottles.indexWhere((bottle) => bottle.id == bottleId);
    if (index != -1) {
      try {
        // Call service to delete bottle on server
        await _bottleService.deleteBottle(bottleId);
        // Remove bottle from local list upon successful deletion
        _bottles.removeAt(index);
        notifyListeners();
      } catch (e) {
        print("Error deleting bottle: $e");
        // Handle deletion error (optional: show a user-friendly message)
      }
    } else {
      print("Bottle with ID: $bottleId not found in local list");
    }
  }
}
