import 'package:flutter/material.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
//import 'package:prompt_system/provider/courseprovider.dart';
//import 'package:provider/provider.dart';


class CourseRegistrationPage extends StatefulWidget {
  final String userType;
  const CourseRegistrationPage({super.key, required this.userType});

  @override
  State<CourseRegistrationPage> createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseCodeController = TextEditingController();
  final List<String> _registeredCourses = [];
  
  void _registerCourse() {
    if (_formKey.currentState!.validate()) {
      setState(() {
       _registeredCourses.add(_courseCodeController.text);
       // Provider.of<CourseProvider>(context, listen: false).addCourse(_courseCodeController.text);
        _courseCodeController.clear();
      });
      _showConfirmationDialog();
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

  void _deleteCourse(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course'),
          content: Text('Are you sure you want to delete "${_registeredCourses[index]}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _registeredCourses.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Course deleted successfully'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleBackNavigation() {
    if (widget.userType == 'Admin') {
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
      body: Padding(
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
