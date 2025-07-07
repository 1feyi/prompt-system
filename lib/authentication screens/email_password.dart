import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/screens/user/user_home.dart';
import 'package:prompt_system/provider/user_provider.dart';

class EmailPasswordScreen extends StatelessWidget {
  const EmailPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async{
    if (_formKey.currentState!.validate()) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final success = await userProvider.login(
          _emailController.text,
          _passwordController.text,
        );

        if (success) {
          // final userType = userProvider.currentUser?.userType;
          final userType = userProvider.currentUser?.userType;
          debugPrint(userType.toString());
          if (userType == 'Admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminHome(userType: 'Admin'),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserHome(
                  userType: 'Student',
                  userName: userProvider.currentUser?.firstName ?? 'Student',
                ),
              ),
            );
          }
        } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF114367),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  const Icon(
                    Icons.school,
                    size: 80,
                    color: Color(0xFF114367),
                  ),
                  const SizedBox(height: 20),
                  // Welcome Text
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF114367),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF114367),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Test Account Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Test Accounts',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF114367),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Admin: admin@test.com / admin123',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Student: student@test.com / student123',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}