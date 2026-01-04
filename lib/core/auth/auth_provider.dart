import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network/core/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  static const _isLoggedInKey = 'is_logged_in';
  static const _userDataKey = 'user_data';

  bool _isLoggedIn = false;
  UserModel? _user;

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get user => _user;
  String? get userEmail => _user?.email;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    final userDataJson = prefs.getString(_userDataKey);
    if (userDataJson != null) {
      try {
        final userData = json.decode(userDataJson) as Map<String, dynamic>;
        _user = UserModel.fromJson(userData);
      } catch (e) {
        // Handle error parsing user data
        _user = null;
      }
    }
    notifyListeners();
  }

  Future<void> login(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final user = UserModel.fromJson(userData);

    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userDataKey, json.encode(user.toJson()));

    _isLoggedIn = true;
    _user = user;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userDataKey);
    _isLoggedIn = false;
    _user = null;
    notifyListeners();
  }

  Future<void> updateUser(UserModel updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, json.encode(updatedUser.toJson()));
    _user = updatedUser;
    notifyListeners();
  }
}
