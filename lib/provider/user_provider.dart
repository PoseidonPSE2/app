import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/model/user_contribution.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';
import 'package:hello_worl2/service/settings/user_contribution_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  RefillStationProvider? _refillStationProvider;
  UserContribution? _userContribution;

  User? get user => _user;
  bool get isLoading => _isLoading;
  UserContribution? get userContribution => _userContribution;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }

  void setRefillStationProvider(RefillStationProvider provider) {
    _refillStationProvider = provider;
  }

  Future<void> fetchDataAfterLogin() async {
    _isLoading = true;
    notifyListeners();
    try {
      print("Daten werden nach dem Login gesammelt...");

      // Fetch refill stations
      await _refillStationProvider?.fetchStations();

      // Fetch user contribution
      final userContributionService = UserContributionService();
      _userContribution =
          await userContributionService.fetchUserContribution(_user!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
