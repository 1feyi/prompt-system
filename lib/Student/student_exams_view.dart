import 'package:flutter/material.dart';

class StudentExamsView extends StatelessWidget {
  const StudentExamsView({super.key});

  // Helper function to group exam entries by date
  Map<String, List<Map<String, dynamic>>> _groupByDate(List<Map<String, dynamic>> exams) {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var entry in exams) {
      String date = entry['date'] as String;
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(entry);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    // Example exam data - this would come from the admin in a real app
    final List<Map<String, dynamic>> exams = [
      {'course': 'CSC 101', 'date': '2024-04-15', 'time': '9:00 AM', 'venue': 'COCCS LAB'},
      {'course': 'MTH 102', 'date': '2024-04-15', 'time': '2:00 PM', 'venue': 'LR 1'},
      {'course': 'PHY 103', 'date': '2024-04-16', 'time': '9:00 AM', 'venue': 'PHY LAB'},
      {'course': 'CHM 104', 'date': '2024-04-16', 'time': '1:00 PM', 'venue': 'CHM BUILDING'},
      {'course': 'ENG 105', 'date': '2024-04-17', 'time': '11:00 AM', 'venue': 'SMS'},
    ];

    final groupedExams = _groupByDate(exams);
    final sortedDates = groupedExams.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sortedDates.length,
          itemBuilder: (context, dateIndex) {
            final date = sortedDates[dateIndex];
            final dateEntries = groupedExams[date] ?? [];
            
            // Format date for display
            final DateTime dateTime = DateTime.parse(date);
            final String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
            final String dayName = _getDayName(dateTime.weekday);
            
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF114367),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Day's Exams
                  if (dateEntries.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'No exams scheduled',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dateEntries.length,
                      itemBuilder: (context, entryIndex) {
                        final entry = dateEntries[entryIndex];
                        
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: entryIndex == dateEntries.length - 1 ? 0 : 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Time
                              SizedBox(
                                width: 100,
                                child: Text(
                                  entry['time'] ?? 'N/A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Course and Venue
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry['course'] ?? 'N/A',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      entry['venue'] ?? 'N/A',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
} 