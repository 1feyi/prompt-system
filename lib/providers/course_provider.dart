import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  final List<String> _courses = [];

  List<String> get courses => _courses;

  void addCourse(String course) {
    if (!_courses.contains(course)) {
      _courses.add(course);
      notifyListeners();
    }
  }

  void removeCourse(String course) {
    _courses.remove(course);
    notifyListeners();
  }
} 