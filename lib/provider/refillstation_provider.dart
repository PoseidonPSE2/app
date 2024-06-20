import 'package:flutter/material.dart';
import 'package:hello_worl2/model/refillstation.dart';
import 'package:hello_worl2/restApi/apiService.dart';

class RefillStationProvider with ChangeNotifier {
  List<RefillStationMarker> _stations = [];
  bool _isLoading = false;
  String? _errorMessage;
  RefillStation? _selectedStation;
  RefillstationReviewAverage? _reviewAverage;
  RefillstationReview? _review;
  int _likes = 0;
  bool _isLiked = false;

  List<RefillStationMarker> get stations => _stations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RefillStation? get selectedStation => _selectedStation;
  RefillstationReviewAverage? get reviewAverage => _reviewAverage;
  RefillstationReview? get review => _review;
  int get likes => _likes;
  bool get isLiked => _isLiked;

  Future<void> fetchStations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _stations = await ApiService().getAllRefillMarker();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch stations';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchStationById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedStation = await ApiService().getRefillstationById(id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch station';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReviewAverage(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _reviewAverage = await ApiService().getRefillStationReviewAverage(id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch review average';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReview(int userid, int stationid) async {
    _isLoading = true;
    notifyListeners();
    try {
      _review =
          await ApiService().getRefillstationReviewByUserId(userid, stationid);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch review';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getLikeCounterForStation(int stationId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _likes = await ApiService().getLikeCounterForStation(stationId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch likes';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getLike(int stationId, int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLiked = await ApiService().getLike(stationId, userId);
    } catch (e) {
      _errorMessage = 'Failed to toggle like';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike(int stationId, int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (!isLiked) {
        await ApiService().postLike(stationId, userId);
      } else {
        await ApiService().deleteLike(stationId, userId);
      }
      await getLikeCounterForStation(stationId);
      _isLiked = !_isLiked;
    } catch (e) {
      _errorMessage = 'Failed to toggle like';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
