import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF114367))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'Your notifications will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'Poppins', color: Color(0xFF114367)),
            ),
            SizedBox(height: 20),
            // Placeholder for notifications list
            Center(
              child: Text('No notifications yet'),
            ),
          ],
        ),
      ),
    );
  }
} 