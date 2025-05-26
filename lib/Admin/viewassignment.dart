import 'package:flutter/material.dart';


class ViewAssignmentPage extends StatelessWidget {
  const ViewAssignmentPage({super.key,});
   final List<Map<String, dynamic>> timetable = const [
    {'course': 'CSC 101', 'date': '26/3/2025', 'time': '10:00 AM'},
    {'course': 'MTH 102', 'date': '26/3/2025', 'time': '12:00 PM'},
    {'course': 'PHY 103', 'date': '3/4/2025', 'time': '2:00 PM',},
    {'course': 'CHM 104', 'date': '5/6/2025', 'time': '9:00 AM',},
    {'course': 'ENG 105', 'date': '8/10/2025', 'time': '11:00 AM',},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text ("View Assignment"),),
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
                  Expanded(child: Text('Due-Date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  Expanded(child:Text('Time', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
               
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
                        Expanded(child: Text(entry['date'] ?? "N/A")),
                        Expanded(child: Text(entry['time'] ?? "N/A")),
                      
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