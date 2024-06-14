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
      print("hier ein fehler");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBottle(Bottle bottle) async {
    await _bottleService.postNewBottle(bottle);
    notifyListeners();
  }

  void removeBottle(int bottleId) async {
    final index = _bottles.indexWhere((bottle) => bottle.id == bottleId);
    if (index != -1) {
      try {
        await _bottleService.deleteBottle(bottleId);
        _bottles.removeAt(index);
        notifyListeners();
      } catch (e) {
        print("Error deleting bottle: $e");
      }
    } else {
      print("Bottle with ID: $bottleId not found in local list");
    }
  }
}
