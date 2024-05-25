import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user; // The current user

  // Getter to access the current user
  User? get user => _user;

  // Method to set the current user
  void setUser(User newUser) {
    _user = newUser;
    notifyListeners(); // Notify listeners of the change
  }

  // Method to remove the current user
  void removeUser() {
    _user = null;
    notifyListeners(); // Notify listeners of the change
  }
}
