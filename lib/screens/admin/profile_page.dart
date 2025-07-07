import 'package:flutter/material.dart';
import 'admin_home.dart';

class ProfilePage extends StatelessWidget {
  final String userType;
  const ProfilePage({super.key, required this.userType});

  void _handleBackNavigation(BuildContext context) {
    // Always navigate back to AdminHome to stay within the admin section
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminHome(userType: 'Admin'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', 
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
              Icons.person,
              size: 80,
              color: Color(0xFF114367),
            ),
            SizedBox(height: 20),
            Text(
              'Admin Profile',
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
                'Profile information will appear here',
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