import 'package:flutter/material.dart';
import 'package:prompt_system/services/timetable_service.dart';

class StudentTimetableView extends StatefulWidget {
  const StudentTimetableView({
    super.key,
  });

  @override
  State<StudentTimetableView> createState() => _StudentTimetableViewState();
}

class _StudentTimetableViewState extends State<StudentTimetableView> {
  List<Map<String, dynamic>> timetable = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTimetable();
  }

  Future<void> _loadTimetable() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final timetableData = await TimetableService.fetchTimetable();
      setState(() {
        timetable = timetableData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading timetable: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper function to group timetable entries by day
  Map<String, List<Map<String, dynamic>>> _groupByDay() {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var entry in timetable) {
      String day = entry['day'] as String;
      if (!grouped.containsKey(day)) {
        grouped[day] = [];
      }
      grouped[day]!.add(entry);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTimetable = _groupByDay();
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Timetable',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTimetable,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF114367),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
          itemCount: days.length,
          itemBuilder: (context, dayIndex) {
            final day = days[dayIndex];
            final dayEntries = groupedTimetable[day] ?? [];
            
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day Header
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
                    child: Text(
                      day,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  
                  // Day's Schedule
                  if (dayEntries.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'No classes scheduled',
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
                      itemCount: dayEntries.length,
                      itemBuilder: (context, entryIndex) {
                        final entry = dayEntries[entryIndex];
                        
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: entryIndex == dayEntries.length - 1 ? 0 : 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Time
                              Container(
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
} 