import 'package:flutter/material.dart';
import 'student_timetable_view.dart';
import 'student_assignments_view.dart';
import 'student_tests_view.dart';
import 'student_exams_view.dart';

class Studenthomepage extends StatelessWidget {
  final String userName;
  final String userType;
  const Studenthomepage({super.key, required this.userName, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CLASS SCHEDULE",
      style:TextStyle(
         fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color:  Color(0xFF114367),
      ) ),),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi $userName,"
          ),

//Next schedule Container 
        Container(
          width: double.infinity,
          height: 140,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF114367).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF114367).withOpacity(0.2),
              width: 1,
            ),
          ),

// Text in Next schedule container 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Next Schedule",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF114367),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color(0xFF114367),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "8:00 AM - CSC 101",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "COCCS LAB",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25,),
        Expanded(child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          children: [
            _buildClickableCard(context, "Timetable", Icons.schedule),
            _buildClickableCard(context, "Assignments", Icons.assignment),
            _buildClickableCard(context, "Test", Icons.quiz),
            _buildClickableCard(context, "Exam", Icons.school)
          ],
          
          ))


      ],) ,

      ),
    );
   
  }
}

Widget _buildClickableCard(BuildContext context, String title, IconData icon) {
  return GestureDetector(
    onTap: () {
      // Common timetable data structure for all views
      final List<Map<String, dynamic>> timetableData = [
        // Monday
        {'course': 'CSC 101', 'day': 'Monday', 'time': '8:00 AM', 'venue': 'COCCS LAB'},
        {'course': 'MTH 102', 'day': 'Monday', 'time': '10:00 AM', 'venue': 'LR 1'},
        {'course': 'PHY 103', 'day': 'Monday', 'time': '2:00 PM', 'venue': 'CHM BUILDING'},
        {'course': 'ENG 105', 'day': 'Monday', 'time': '4:00 PM', 'venue': 'SMS'},
        
        // Tuesday
        {'course': 'CSC 201', 'day': 'Tuesday', 'time': '9:00 AM', 'venue': 'COCCS LAB'},
        {'course': 'MTH 202', 'day': 'Tuesday', 'time': '11:00 AM', 'venue': 'LR 2'},
        {'course': 'PHY 203', 'day': 'Tuesday', 'time': '1:00 PM', 'venue': 'PHY LAB'},
        {'course': 'CHM 204', 'day': 'Tuesday', 'time': '3:00 PM', 'venue': 'CHM BUILDING'},
        
        // Wednesday
        {'course': 'CSC 301', 'day': 'Wednesday', 'time': '8:00 AM', 'venue': 'COCCS LAB'},
        {'course': 'MTH 302', 'day': 'Wednesday', 'time': '10:00 AM', 'venue': 'LR 3'},
        {'course': 'PHY 303', 'day': 'Wednesday', 'time': '2:00 PM', 'venue': 'PHY LAB'},
        {'course': 'ENG 305', 'day': 'Wednesday', 'time': '4:00 PM', 'venue': 'SMS'},
        
        // Thursday
        {'course': 'CSC 401', 'day': 'Thursday', 'time': '9:00 AM', 'venue': 'COCCS LAB'},
        {'course': 'MTH 402', 'day': 'Thursday', 'time': '11:00 AM', 'venue': 'LR 4'},
        {'course': 'PHY 403', 'day': 'Thursday', 'time': '1:00 PM', 'venue': 'PHY LAB'},
        {'course': 'CHM 404', 'day': 'Thursday', 'time': '3:00 PM', 'venue': 'CHM BUILDING'},
        
        // Friday
        {'course': 'CSC 501', 'day': 'Friday', 'time': '8:00 AM', 'venue': 'COCCS LAB'},
        {'course': 'MTH 502', 'day': 'Friday', 'time': '10:00 AM', 'venue': 'LR 5'},
        {'course': 'PHY 503', 'day': 'Friday', 'time': '2:00 PM', 'venue': 'PHY LAB'},
        {'course': 'ENG 505', 'day': 'Friday', 'time': '4:00 PM', 'venue': 'SMS'},
      ];

      switch (title) {
        case "Timetable":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentTimetableView(timetable: timetableData),
            ),
          );
          break;
        case "Assignments":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StudentAssignmentsView()),
          );
          break;
        case "Test":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentTestsView(),
            ),
          );
          break;
        case "Exam":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentExamsView(),
            ),
          );
          break;
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF114367),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 50),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  );
}

