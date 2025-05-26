import 'package:flutter/material.dart';

class Viewtimetablepage extends StatelessWidget {
  const Viewtimetablepage({super.key});

  //  Timetable
  final List<Map<String, String>> timetable = const [
    {'course': 'CSC 101', 'day': 'Monday', 'time': '10:00 AM', 'venue': 'COCCS'},
    {'course': 'MTH 102', 'day': 'Tuesday', 'time': '12:00 PM', 'venue': 'LR 1'},
    {'course': 'PHY 103', 'day': 'Wednesday', 'time': '2:00 PM', 'venue': 'CHM BUILDING'},
    {'course': 'CHM 104', 'day': 'Thursday', 'time': '9:00 AM', 'venue': 'ALMA ROHM'},
    {'course': 'ENG 105', 'day': 'Friday', 'time': '11:00 AM', 'venue': 'SMS'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Timetable')),
      body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            // Header Row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
              color: const Color(0xFF114367),
              child: const Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Course', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  Expanded(child: Text('Day', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  Expanded(child:Text('Time', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  Expanded(child: Text('Venue', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
               
                ],
              ),
            ),
            
            const SizedBox(height: 10), // Adds spacing
            
            // Timetable Entries
            Expanded(
              child: ListView.builder(
                itemCount: timetable.length,
                itemBuilder: (context, index) {
                  final entry = timetable[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(entry['course'] ?? "N/A")),
                        Expanded(child: Text(entry['day'] ?? "N/A")),
                        Expanded(child: Text(entry['time'] ?? "N/A")),
                        Expanded(child: Text(entry['venue'] ?? "N/A")),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}