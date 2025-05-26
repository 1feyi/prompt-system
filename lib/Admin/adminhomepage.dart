import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/assignmentpage.dart';
import 'package:prompt_system/Admin/classtimetable.dart';
import 'package:prompt_system/Admin/registrationpage.dart';
import 'package:prompt_system/Admin/uploadpage.dart';
import 'package:prompt_system/Admin/notificationspage.dart';
import 'testpage.dart';
import 'exampage.dart';
import 'announcementpage.dart';
//import 'package:prompt_system/provider/courseprovider.dart';
//import 'package:provider/provider.dart';

class Adminhomepage extends StatefulWidget {
  final String userType;
  const Adminhomepage({super.key, required this.userType});

  @override
  State<Adminhomepage> createState() => _AdminhomepageState();
}

class _AdminhomepageState extends State<Adminhomepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CourseRegistrationPage(),
    const UploadPage(),
    const NotificationsPage(),
  ];

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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      appBar: AppBar(title: const Text("Admin")),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(menuItems[index]['icon']),
            title: Text(menuItems[index]['title']),
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