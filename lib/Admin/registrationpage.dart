import 'package:flutter/material.dart';
//import 'package:prompt_system/provider/courseprovider.dart';
//import 'package:provider/provider.dart';


class CourseRegistrationPage extends StatefulWidget {
  const CourseRegistrationPage({super.key});

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
                // Navigate to the desired section after registration
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Courses'),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
            controller: _courseCodeController, 
            decoration: const InputDecoration(labelText: 'Course Code'), 
            validator: (value){
              if (value==null || value.isEmpty){
                return 'Please enter a course code';
              }
              return null;
            }
            
            )

          ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerCourse,
              child: const Text('Register Course'),
            ),
             const SizedBox(height: 20),
            Expanded(
              child:ListView.builder (
                    itemCount: _registeredCourses.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(_registeredCourses[index]),
                      );
                    }
                  
              ),
                  ),
        ],
      ),
      ),
    );

                }
  }
