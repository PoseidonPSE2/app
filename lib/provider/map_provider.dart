import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class MapProvider with ChangeNotifier {
  bool _isToggled = false;
  LatLng _userLocation = const LatLng(0.0, 0.0);
  bool _shouldCenterMap = false;

  bool get isToggled => _isToggled;
  LatLng get getUserLocation => _userLocation;
  bool get shouldCenterMap => _shouldCenterMap;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners();
  }

  void setPosition(LatLng currentLocation) {
    _userLocation = currentLocation;
    notifyListeners();
  }

  void centerMap() {
    _shouldCenterMap = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 100), () {
      _shouldCenterMap = false;
      notifyListeners();
    });
  }
}
