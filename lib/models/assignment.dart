class Assignment {
  final String course;
  final String title;
  final String description;
  final DateTime dueDate;
  final String dueTime;
  String status; // 'pending', 'completed', 'overdue'
  bool isOverdue;

  Assignment({
    required this.course,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.dueTime,
    this.status = 'pending',
    this.isOverdue = false,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'course': course,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'dueTime': dueTime,
      'status': status,
      'isOverdue': isOverdue,
    };
  }

  // Create from Map
  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      course: map['course'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      dueTime: map['dueTime'],
      status: map['status'],
      isOverdue: map['isOverdue'],
    );
  }

  // Check if assignment is overdue
  void checkOverdue() {
    final now = DateTime.now();
    final dueDateTime = DateTime(
      dueDate.year,
      dueDate.month,
      dueDate.day,
      int.parse(dueTime.split(':')[0]),
      int.parse(dueTime.split(':')[1].split(' ')[0]),
    );
    
    if (now.isAfter(dueDateTime) && status != 'completed') {
      status = 'overdue';
      isOverdue = true;
    }
  }

  // Mark as complete
  void markAsComplete() {
    status = 'completed';
    isOverdue = false;
  }
} 