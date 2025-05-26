import 'package:flutter/material.dart';
import 'emailpassword.dart';

class SignUpDetailsScreen extends StatelessWidget {
  final String userType;
  const SignUpDetailsScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Details', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF114367))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'Enter your details',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'Poppins', color: Color(0xFF114367)),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // TODO: Implement actual signup logic
          // For now, navigate to email/password screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EmailPasswordScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF114367),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text('Next', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
      ),
    );
  }
}