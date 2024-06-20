import 'package:flutter/cupertino.dart';

class RatingProvider extends ChangeNotifier {
  int _cleanlinessRating = 0;
  int _accessibilityRating = 0;
  int _waterQualityRating = 0;

  int get cleanlinessRating => _cleanlinessRating;
  int get accessibilityRating => _accessibilityRating;
  int get waterQualityRating => _waterQualityRating;

  set cleanlinessRating(int value) {
    _cleanlinessRating = value;
    notifyListeners();
  }

  set accessibilityRating(int value) {
    _accessibilityRating = value;
    notifyListeners();
  }

  set waterQualityRating(int value) {
    _waterQualityRating = value;
    notifyListeners();
  }
}