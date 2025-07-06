import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prompt_system/provider/user_provider.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/screens/user/user_home.dart';

class SchoolDetailsScreen extends StatefulWidget {
  final String userType;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const SchoolDetailsScreen({
    super.key,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  State<SchoolDetailsScreen> createState() => _SchoolDetailsScreenState();
}

class _SchoolDetailsScreenState extends State<SchoolDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  String _selectedDepartment = 'Computer Science';
  String _selectedLevel = '100';

  final List<String> _levels = ['100', '200', '300', '400', '500'];
  final List<String> _departments = [
    'Computer Science',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Civil Engineering',
    'Chemical Engineering',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'Business Administration',
    'Economics',
    'Psychology',
    'Sociology',
    'Political Science',
    'English',
    'History',
    'Philosophy',
    'Fine Arts',
    'Architecture',
    'Medicine',
  ];

  @override
  void dispose() {
    _schoolController.dispose();
    super.dispose();
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      final newUser = User(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        password: widget.password,
        userType: widget.userType,
        school: _schoolController.text,
        department: _selectedDepartment,
        level: _selectedLevel,
      );

      final success = userProvider.register(newUser);

      if (await success) {
        // Automatically log in the user
        final loginSuccess = userProvider.login(
          widget.email,
          widget.password,
        );

        if (await loginSuccess) {
          // Navigate to the appropriate home screen
          if (widget.userType == 'Admin') {
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
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email already exists'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Details'),
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
                  Text(
                    'Complete ${widget.userType} Profile',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF114367),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 30),
                  // School Field
                  TextFormField(
                    controller: _schoolController,
                    decoration: InputDecoration(
                      labelText: 'School',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.school),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your school';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Department Field
                  DropdownButtonFormField<String>(
                    value: _selectedDepartment,
                    decoration: InputDecoration(
                      labelText: 'Department',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.business),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    menuMaxHeight: 300,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: _departments.map((String department) {
                      return DropdownMenuItem<String>(
                        value: department,
                        child: Text(
                          department,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedDepartment = newValue;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your department';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Level Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedLevel,
                    decoration: InputDecoration(
                      labelText: 'Level',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.school),
                    ),
                    items: _levels.map((String level) {
                      return DropdownMenuItem<String>(
                        value: level,
                        child: Text('Level $level'),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedLevel = newValue;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your level';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF114367),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Complete Registration',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
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