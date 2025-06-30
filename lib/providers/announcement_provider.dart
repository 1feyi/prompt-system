import 'package:flutter/material.dart';

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

  List<Announcement> get allAnnouncements => _announcements;
  List<Announcement> get unreadAnnouncements => 
      _announcements.where((a) => !a.isRead).toList();

  void addAnnouncement(String course, String message) {
    final announcement = Announcement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      course: course,
      message: message,
      timestamp: DateTime.now(),
    );
    _announcements.insert(0, announcement);
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _announcements.indexWhere((a) => a.id == id);
    if (index != -1) {
      _announcements[index].isRead = true;
      notifyListeners();
    }
  }

  // For testing purposes
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
} 