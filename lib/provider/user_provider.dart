import 'package:flutter/material.dart';
import 'package:refill/model/user.dart';
import 'package:refill/model/user_contribution.dart';
import 'package:refill/provider/refillstation_provider.dart';
import 'package:refill/service/drawer/community_service.dart';
import 'package:refill/service/drawer/kl_contribution_service.dart';
import 'package:refill/service/drawer/user_contribution_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  RefillStationProvider? _refillStationProvider;
  UserContribution? _userContribution;
  Map<String, dynamic>? _klContribution;
  Map<String, dynamic>? _communityContribution;

  User? get user => _user;
  bool get isLoading => _isLoading;
  UserContribution? get userContribution => _userContribution;
  Map<String, dynamic>? get klContribution => _klContribution;
  Map<String, dynamic>? get communityContribution => _communityContribution;

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

      fetchUserContribution();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserContribution() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userContributionService = UserContributionService();
      _userContribution =
          await userContributionService.fetchUserContribution(_user!);

      final klContributionService = KLContributionService();
      _klContribution = await klContributionService.fetchKLContribution();

      final communityService = CommunityService();
      _communityContribution =
          await communityService.fetchCommunityContribution();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
