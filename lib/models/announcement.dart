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

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course': course,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  // Create from Map
  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'],
      course: map['course'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'],
    );
  }

  // Mark as read
  void markAsRead() {
    isRead = true;
  }
} 