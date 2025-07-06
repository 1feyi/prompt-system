import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/websocket_service.dart';

class Announcement {
  final String id;
  final String course;
  final String message;
  final DateTime timestamp;
  bool isRead;

  Announcement({
    required this.id,
    required this.course,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}

class AnnouncementProvider extends ChangeNotifier {
  final List<Announcement> _announcements = [];
  final WebSocketService _webSocketService = WebSocketService();

  List<Announcement> get allAnnouncements => _announcements;
  List<Announcement> get unreadAnnouncements =>
      _announcements.where((a) => !a.isRead).toList();

  AnnouncementProvider() {
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    _webSocketService.connect();
    _webSocketService.messages.listen((data) {
      _handleIncomingMessage(data);
    });
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      print('Received WebSocket message: $data');
      
      Map<String, dynamic> decoded;
      if (data is String) {
        decoded = jsonDecode(data);
      } else if (data is Map<String, dynamic>) {
        decoded = data;
      } else {
        print('Unexpected message format: $data');
        return;
      }

      if (decoded['type'] == 'announcement') {
        final course = decoded['course'] ?? '';
        final message = decoded['message'] ?? '';
        final timestamp = decoded['timestamp'] != null
              ? DateTime.parse(decoded['timestamp'])
            : DateTime.now();

        print('Adding announcement: $course - $message');
        addAnnouncementFromServer(course, message, timestamp);
      }
    } catch (e) {
      print('Error parsing WebSocket message: $e');
      print('Raw message: $data');
    }
  }

  void addAnnouncementFromServer(String course, String message, DateTime timestamp) {
    final announcement = Announcement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      course: course,
      message: message,
      timestamp: timestamp,
    );
    _announcements.insert(0, announcement);
    notifyListeners();
    print('Announcement added: ${announcement.course} - ${announcement.message}');
  }

  void addAnnouncement(String course, String message) {
    final announcement = Announcement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      course: course,
      message: message,
      timestamp: DateTime.now(),
    );
    _announcements.insert(0, announcement);
    notifyListeners();

    // Send to server via WebSocket
    final payload = jsonEncode({
      'type': 'announcement',
      'course': course,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
    _webSocketService.sendMessage(payload);
  }

  void markAsRead(String id) {
    final index = _announcements.indexWhere((a) => a.id == id);
    if (index != -1) {
      _announcements[index].isRead = true;
      notifyListeners();
    }
  }

  void disposeWebSocket() {
    _webSocketService.close();
  }

  void addSampleAnnouncements() {
    if (_announcements.isEmpty) {
      addAnnouncement(
        'CSC 101',
        'Important: Next class will be held in the COCCS LAB instead of the regular classroom.',
      );
      addAnnouncement(
        'MTH 102',
        'Assignment deadline has been extended to next Friday.',
      );
      addAnnouncement(
        'PHY 103',
        'Lab session tomorrow will focus on practical experiments.',
      );
    }
  }

  @override
void dispose() {
  disposeWebSocket();
  super.dispose();
}
} 
