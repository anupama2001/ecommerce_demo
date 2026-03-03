import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final List<Map<String, String>> _users = [];

  bool _isLoggedIn = false;
  String? _currentUserEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUserEmail => _currentUserEmail;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  String? signup({required String email, required String password}) {
    if (email.isEmpty || password.isEmpty) {
      return "Fields cannot be empty";
    }

    if (!email.contains("@")) {
      return "Invalid email format";
    }

    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }

    final exists = _users.any((user) => user['email'] == email);

    if (exists) {
      return "User already exists";
    }

    _users.add({'email': email, 'password': password});

    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final user = _users.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return "Invalid credentials";
    }

    _isLoggedIn = true;
    _currentUserEmail = email;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _currentUserEmail = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    notifyListeners();
  }
}
