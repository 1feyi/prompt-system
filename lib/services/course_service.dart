import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CourseService {
  static const String baseUrl = 'https://406d-197-211-63-157.ngrok-free.app/api/course'; // Update to your backend URL

  static Future<List<String>> fetchCourses() async {
    debugPrint("entered fetching");
    final response = await http.get(Uri.parse(baseUrl));
    debugPrint("gotten response: "+response.body);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        debugPrint("parsed data: $data");
        return data.map<String>((course) => course['course'] as String).toList();
      } catch (e) {
        debugPrint("Error parsing courses: $e");
        return [];
      }
    } else {
      debugPrint("Failed to load courses: ${response.statusCode}");
      throw Exception('Failed to load courses');
    }
  }

  static Future<bool> addCourse(String courseName) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'course': courseName}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteCourse(String courseName) async {
    final response = await http.delete(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'course': courseName}),
    );
    return response.statusCode == 200;
  }
} 