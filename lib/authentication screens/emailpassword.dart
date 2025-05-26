import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/adminhomepage.dart';
import 'package:prompt_system/Student/studenthomepage.dart';

class EmailPasswordScreen extends StatelessWidget {
  const EmailPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF114367))),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.school, size: 100, color: Color(0xFF114367)),
                const SizedBox(height: 20),
                const Text(
                  'Enter your email and password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins', color: Color(0xFF114367)),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Default test account
                    const String testEmail = 'test@example.com';
                    const String testPassword = 'password123';

                    // TODO: Implement actual login logic
                    // For now, navigate to admin or student homepage based on a condition
                    bool isAdmin = true; // Replace with actual logic
                    if (isAdmin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Adminhomepage(userType: 'Admin')),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Studenthomepage(userName: 'Student', userType: 'Student')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF114367),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Login', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}