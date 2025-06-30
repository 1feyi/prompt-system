import 'package:flutter/material.dart';

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

  bool login(String email, String password) {
    try {
    final user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: () => throw Exception('Invalid email or password'),
    );
    
    _currentUser = user;
    notifyListeners();
    return true;
    } catch (e) {
      return false;
    }
  }

  bool register(User user) {
    // Check if user already exists
    if (_users.any((u) => u.email == user.email)) {
      return false;
    }
    
    _users.add(user);
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
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