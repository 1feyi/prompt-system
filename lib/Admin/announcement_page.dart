import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/announcement_provider.dart';
import 'dart:convert';
import '../services/websocket_service.dart';
import '../screens/admin/admin_home.dart';
import '../Admin/registration_page.dart';
import '../Admin/upload_page.dart';
import '../screens/admin/profile_page.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final List<Map<String, String>> courses = [
    {'course': 'CSC 101'},
    {'course': 'MTH 102'},
    {'course': 'PHY 103'},
    {'course': 'CHM 104'},
    {'course': 'ENG 105'},
  ];

  String? selectedCourse;
  final TextEditingController messageController = TextEditingController();
  final WebSocketService _webSocketService = WebSocketService();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _webSocketService.connect();
  }

  @override
  void dispose() {
    _webSocketService.close();
    super.dispose();
  }

  void sendAnnouncement() async {
    if (selectedCourse == null || messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all fields"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      // Send via WebSocket
      final payload = jsonEncode({
        'type': 'announcement',
        'course': selectedCourse,
        'message': messageController.text,
        'timestamp': DateTime.now().toIso8601String(),
      });
      
      _webSocketService.sendMessage(payload);

      // Also add to local provider for immediate display
      final announcementProvider = Provider.of<AnnouncementProvider>(context, listen: false);
      announcementProvider.addAnnouncement(selectedCourse!, messageController.text);

      // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Announcement sent for $selectedCourse"),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      // Clear input fields
    setState(() {
      selectedCourse = null;
      messageController.clear();
    });

      // Navigate back after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send announcement: $e"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Announcement",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pop(context);
        },
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Course",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              ),
              const SizedBox(height: 8),

              // Course Selection Dropdown
              DropdownButtonFormField<String>(
                value: selectedCourse,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                hint: const Text("Choose a course"),
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

              // Message Input Field
              const Text(
                "Enter Announcement Message",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Enter your announcement here...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 20),

              // Send Button
              SizedBox(
              width: double.infinity,
                child: ElevatedButton.icon(
                icon: _isSending 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.white),
                label: Text(
                  _isSending ? "Sending..." : "Send Announcement",
                  style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  backgroundColor: const Color(0xFF114367),
                  ),
                onPressed: _isSending ? null : sendAnnouncement,
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