import 'package:flutter/material.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/services/course_service.dart';

class CourseRegistrationPage extends StatefulWidget {
  final String userType;
  const CourseRegistrationPage({super.key, required this.userType});

  @override
  State<CourseRegistrationPage> createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseCodeController = TextEditingController();
  List<String> _registeredCourses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    setState(() { _isLoading = true; });
    try {
      _registeredCourses = await CourseService.fetchCourses();
    } catch (e) {
      // handle error
    }
    setState(() { _isLoading = false; });
  }

  Future<void> _registerCourse() async {
    if (_formKey.currentState!.validate()) {
      final courseName = _courseCodeController.text;
      final success = await CourseService.addCourse(courseName);
      if (success) {
        setState(() {
          _registeredCourses.add(courseName);
        });
        _courseCodeController.clear();
        _showConfirmationDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register course'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Course code successfully registered.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> _deleteCourse(int index) async {
    final courseName = _registeredCourses[index];
    final success = await CourseService.deleteCourse(courseName);
    if (success) {
      setState(() {
        _registeredCourses.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course deleted successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete course'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleBackNavigation() {
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
        title: const Text('Register Courses',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF114367),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBackNavigation,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _courseCodeController,
                decoration: InputDecoration(
                  labelText: 'Course Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course code';
                  }
                  return null;
                }
              )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerCourse,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF114367),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Register Course',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registered Courses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF114367),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _registeredCourses.isEmpty
                        ? const Center(
                            child: Text(
                              'No courses registered yet',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _registeredCourses.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.school,
                                    color: Color(0xFF114367),
                                  ),
                                  title: Text(
                                    _registeredCourses[index],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF114367),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Course Code',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteCourse(index),
                                    tooltip: 'Delete course',
                                  ),
                                ),
                              );
                            }
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
