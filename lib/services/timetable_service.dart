import 'dart:convert';
import 'package:http/http.dart' as http;

class TimetableService {
  static const String baseUrl = 'https://406d-197-211-63-157.ngrok-free.app/api';

  // Fetch all timetable entries from the backend
  static Future<List<Map<String, dynamic>>> fetchTimetable() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/timetable'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => {
          'course': item['course'] ?? '',
          'day': item['day'] ?? '',
          'time': item['time'] ?? '',
          'venue': item['venue'] ?? '',
        }).toList();
      } else {
        print('Failed to fetch timetable: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching timetable: $e');
      return [];
    }
  }

  // Save a new timetable entry to the backend
  static Future<bool> saveTimetableEntry({
    required String course,
    required String day,
    required String time,
    required String venue,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/timetable'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'course': course,
          'day': day,
          'time': time,
          'venue': venue,
        }),
      );

      if (response.statusCode == 201) {
        print('Timetable entry saved successfully');
        return true;
      } else {
        print('Failed to save timetable entry: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error saving timetable entry: $e');
      return false;
    }
  }

  // Delete a timetable entry from the backend
  static Future<bool> deleteTimetableEntry(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/timetable/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Timetable entry deleted successfully');
        return true;
      } else {
        print('Failed to delete timetable entry: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting timetable entry: $e');
      return false;
    }
  }
} 