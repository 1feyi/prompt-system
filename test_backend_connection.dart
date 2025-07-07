import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  const String baseUrl = 'https://eca7-105-113-57-185.ngrok-free.app/api';
  
  print('Testing backend connection...');
  
  try {
    // Test GET request
    print('Testing GET /timetable...');
    final getResponse = await http.get(
      Uri.parse('$baseUrl/timetable'),
      headers: {'Content-Type': 'application/json'},
    );
    
    print('GET Response Status: ${getResponse.statusCode}');
    print('GET Response Body: ${getResponse.body}');
    
    // Test POST request
    print('\nTesting POST /timetable...');
    final postResponse = await http.post(
      Uri.parse('$baseUrl/timetable'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'course': 'TEST 101',
        'day': 'Monday',
        'time': '9:00 AM',
        'venue': 'TEST LAB',
      }),
    );
    
    print('POST Response Status: ${postResponse.statusCode}');
    print('POST Response Body: ${postResponse.body}');
    
    if (getResponse.statusCode == 200 && postResponse.statusCode == 201) {
      print('\n✅ Backend connection is working properly!');
    } else {
      print('\n❌ Backend connection has issues.');
    }
    
  } catch (e) {
    print('\n❌ Error connecting to backend: $e');
  }
} 