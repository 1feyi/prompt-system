import 'package:flutter/material.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/screens/user/user_home.dart';
import 'select_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSavedUserType();
  }

  Future<void> _checkSavedUserType() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      // Always navigate to user selection screen to ensure proper authentication flow
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectUser()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100, color: Color(0xFF114367)),
            SizedBox(height: 20),
            Text(
              'Prompt System',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFF114367),
              ),
            ),
          ],
        ),
      ),
    );
  }
}