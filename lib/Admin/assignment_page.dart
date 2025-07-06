import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/view_assignment.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/Admin/registration_page.dart';
import 'package:prompt_system/Admin/upload_page.dart';
import 'package:prompt_system/screens/admin/profile_page.dart';


class Assignmentpage extends StatefulWidget {
  const Assignmentpage({super.key});

  @override
  State<Assignmentpage> createState() => _AssignmentpageState();
}

class _AssignmentpageState extends State<Assignmentpage> {
  final List<Map<String,String>> courses = [
    {'course': 'CSC 101'},
    {'course': 'MTH 102'},
    {'course': 'PHY 103'},
    {'course': 'CHM 104'},
    {'course': 'ENG 105'},

  ];
  final TextEditingController assignmentController = TextEditingController();


  String? selectedCourse;
  String? selectedDate;
  String? selectedTime;


  final List<String> times = [
    '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
    '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00PM', '7:00PM', '8:00PM', '9:00PM', '10:00PM', 
  ];
  void _submitAssignment() {
    if (selectedCourse == null || assignmentController.text.isEmpty || selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete all fields"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
     // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Assignment Submitted Successfully"),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate to view page after delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewAssignmentPage()),
      );
    });

    setState(() {
      selectedCourse = null;
      assignmentController.clear();
      selectedDate = null;
      selectedTime = null;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Course", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCourse,
              hint: const Text("Choose a course"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: courses.map((course) {
                return DropdownMenuItem(
                  value: course['course'],
                  child: Text(course['course']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCourse = value;
                });
              },
            ),
            const SizedBox(height: 16),

            const Text("Enter Assignment Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: assignmentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Enter the assignment here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Select Submission Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedDate ?? "Select Date",
                  style: const TextStyle(color: Color(0xFF114367), fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Select Submission Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedTime,
              hint: const Text("Choose a time"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: times.map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTime = value;
                });
              },
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text("Submit Assignment"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: const Color(0xFF114367),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: _submitAssignment,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Home is selected
        onTap: (index) {
          _navigateToAdminPage(context, index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _navigateToAdminPage(BuildContext context, int index) {
    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        break;
      case 1: // Registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        // Navigate to registration page
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseRegistrationPage(userType: 'Admin'),
            ),
          );
        });
        break;
      case 2: // Upload
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        // Navigate to upload page
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadPage(),
            ),
          );
        });
        break;
      case 3: // Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        // Navigate to profile page
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(userType: 'Admin'),
            ),
          );
        });
        break;
    }
  }
}