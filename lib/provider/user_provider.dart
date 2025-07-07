import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String userType;
  final String school;
  final String department;
  final String level;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.userType,
    required this.school,
    required this.department,
    required this.level,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      userType: json['userType'] as String,
      school: json['school'] as String,
      department: json['department'] as String,
      level: json['level'] as String,
    );
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, password: $password, userType: $userType, school: $school, department: $department, level: $level)';
  }
}

class UserProvider extends ChangeNotifier {
  // Test users
  final List<User> _users = [
    // Admin test user
    User(
      firstName: 'Admin',
      lastName: 'User',
      email: 'admin@test.com',
      password: 'admin123',
      userType: 'Admin',
      school: 'University of Technology',
      department: 'Computer Science',
      level: '100',
    ),
    // Student test user
    User(
      firstName: 'Student',
      lastName: 'User',
      email: 'student@test.com',
      password: 'student123',
      userType: 'Student',
      school: 'University of Technology',
      department: 'Computer Science',
      level: '100',
    ),
  ];

  User? _currentUser;

  User? get currentUser => _currentUser;

  // Session persistence keys
  static const String _userTypeKey = 'user_type';

  // Save user type to storage
  Future<void> _saveUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, userType);
  }

  // Get saved user type from storage
  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  // Clear saved user type
  Future<void> _clearUserType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTypeKey);
  }

  Future<bool> login(String email, String password) async {
    try {
      // final user = _users.firstWhere(
      //     (user) => user.email == email && user.password == password,
      //     orElse: () => throw Exception('Invalid email or password'),
      // );

      // _currentUser = user;
      // notifyListeners();
      // return true;

      // final url = Uri.parse('http://localhost:3000/api/auth/login');  // replace with your API URL
      final url = Uri.parse(
          'https://406d-197-211-63-157.ngrok-free.app/api/auth/login'); // replace with your API URL

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        // Login successful
        final data = jsonDecode(response.body);
        debugPrint(data['user'].toString());
        _currentUser = User.fromJson(data['user']);
        _currentUser != null
            ? debugPrint(_currentUser.toString())
            : debugPrint("User not converted");
        
        // Save user type for session persistence
        if (_currentUser != null) {
          await _saveUserType(_currentUser!.userType);
        }
        
        notifyListeners();
        return true;
      } else {
        // Handle failure (e.g. user exists, server error)
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(User user) async {
    // Check if user already exists
    // if (_users.any((u) => u.email == user.email)) {
    //   return false;
    // }

    // _users.add(user);
    // notifyListeners();
    // return true;

    // final url = Uri.parse('http://localhost:3000/api/auth/register');  // replace with your API URL
    final url = Uri.parse(
        'https://406d-197-211-63-157.ngrok-free.app/api/auth/register'); // replace with your API URL

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstname': user.firstName,
        'lastname': user.lastName,
        'department': user.department,
        'level': user.level,
        'email': user.email,
        'isAdmin': user.userType == "Admin" ? true : false,
        'password': user.password, // assuming you have a password field
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Registration successful
      notifyListeners();
      return true;
    } else {
      // Handle failure (e.g. user exists, server error)
      print('Registration failed: ${response.body}');
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _clearUserType();
    notifyListeners();
  }

  void updateUser(User updatedUser) {
    final index = _users.indexWhere((user) => user.email == updatedUser.email);
    if (index != -1) {
      _users[index] = updatedUser;
      if (_currentUser?.email == updatedUser.email) {
        _currentUser = updatedUser;
      }
      notifyListeners();
    }
  }
}
