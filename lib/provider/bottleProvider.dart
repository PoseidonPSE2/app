import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/service/new_bottle_service.dart';

class BottleProvider extends ChangeNotifier {
  List<Bottle> _bottles = [];
  bool _isLoading = false;

  List<Bottle> get bottles => _bottles;
  bool get isLoading => _isLoading;

  final BottleService _bottleService = BottleService();

  BottleProvider() {
    fetchBottles();
  }

  Future<void> fetchBottles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _bottles = await _bottleService.fetchBottles();
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addBottle(Bottle bottle) {
    _bottles.add(bottle);
    notifyListeners();
  }

  void removeBottle(String bottleId) {
    _bottles.removeWhere((bottle) => bottle.id.toString() == bottleId);
    notifyListeners();
  }
}
