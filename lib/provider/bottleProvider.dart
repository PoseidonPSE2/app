import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';

class BottleProvider extends ChangeNotifier {
  List<Bottle> _bottles = [];

  List<Bottle> get bottles => _bottles;

  void addBottle(Bottle bottle) {
    _bottles.add(bottle);
    notifyListeners();
  }

  void removeBottle(String bottleId) {
    _bottles.removeWhere((bottle) => bottle.title == bottleId);
    notifyListeners();
  }
}
