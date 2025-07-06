import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/assignment_page.dart';
import 'package:prompt_system/Admin/class_timetable.dart';
import 'package:prompt_system/Admin/registration_page.dart';
import 'package:prompt_system/Admin/upload_page.dart';
import 'package:prompt_system/Admin/test_page.dart';
import 'package:prompt_system/Admin/exam_page.dart';
import 'package:prompt_system/Admin/announcement_page.dart';
import 'profile_page.dart';

class AdminHome extends StatefulWidget {
  final String userType;
  const AdminHome({super.key, required this.userType});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const AdminDashboard(),
      CourseRegistrationPage(userType: widget.userType),
      const UploadPage(),
      ProfilePage(userType: widget.userType),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF114367),
        unselectedItemColor: Colors.grey,
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
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Class Timetables', 'icon': Icons.schedule, 'page': const ClassTimetablesPage()},
      {'title': 'Assignments', 'icon': Icons.assignment, 'page': const Assignmentpage()},
      {'title': 'Tests', 'icon': Icons.quiz, 'page': const Testpage()},
      {'title': 'Exams', 'icon': Icons.school, 'page': const Exampage()},
      {'title': 'Announcements', 'icon': Icons.announcement, 'page': const AnnouncementPage()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xFF114367),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(menuItems[index]['icon'], color: const Color(0xFF114367)),
            title: Text(
              menuItems[index]['title'],
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF114367),
              ),
            ),
            onTap: () {
              if (menuItems[index]['page'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => menuItems[index]['page'],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
} 