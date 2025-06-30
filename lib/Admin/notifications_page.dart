import 'package:flutter/material.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';

class NotificationsPage extends StatelessWidget {
  final String userType;
  const NotificationsPage({super.key, required this.userType});

  void _handleBackNavigation(BuildContext context) {
    if (userType == 'Admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminHome(userType: 'Admin'),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', 
          style: TextStyle(
            fontFamily: 'Poppins', 
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367)
          )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBackNavigation(context),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.notifications_none,
              size: 80,
              color: Color(0xFF114367),
            ),
            SizedBox(height: 20),
            Text(
              'Your notifications will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, 
                fontFamily: 'Poppins', 
                fontWeight: FontWeight.w500,
                color: Color(0xFF114367)
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'No notifications yet',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 