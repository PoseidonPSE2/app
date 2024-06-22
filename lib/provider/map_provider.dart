import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class MapProvider with ChangeNotifier {
  bool _isToggled = false;
  LatLng _userLocation = const LatLng(0.0, 0.0);

  bool get isToggled => _isToggled;
  LatLng get getUserLocation => _userLocation;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners();
  }
  void setPosition(LatLng currentLocation) {
    _userLocation = currentLocation;
    notifyListeners();

  }
}