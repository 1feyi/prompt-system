import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/view_timetable_page.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/Admin/registration_page.dart';
import 'package:prompt_system/Admin/upload_page.dart';
import 'package:prompt_system/screens/admin/profile_page.dart';


class ClassTimetablesPage extends StatefulWidget {
  const ClassTimetablesPage({super.key});

  @override
  State<ClassTimetablesPage> createState() => _ClassTimetablesPageState();
}

class _ClassTimetablesPageState extends State<ClassTimetablesPage> {
  final List<Map<String, String>> courses = [
    {'course': 'CSC 101'},
    {'course': 'MTH 102'},
    {'course': 'PHY 103'},
    {'course': 'CHM 104'},
    {'course': 'ENG 105'},
  ];

  // Structure to store multiple schedules per course
  final Map<String, List<Map<String, String>>> courseSchedules = {};

  final List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
  ];

  final List<String> times = [
    '8:00AM', '9:00AM', '10:00AM', '11:00AM', '12:00PM', 
    '1:00PM', '2:00PM', '3:00PM', '4:00PM', '5:00PM', 
  ];

  final List<String> venues = [
    'CALT', 'COLAW', 'SMS', 'ALMA ROHM', 'NEW HORIZON', 
    'CHM BUILDING', 'COCCS',
  ];

  void _addSchedule(String courseName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedDay;
        String? selectedTime;
        String? selectedVenue;

        return AlertDialog(
          title: Text('Add Schedule for $courseName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Day Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                ),
                value: selectedDay,
                items: daysOfWeek.map((String day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedDay = newValue;
                },
              ),
              const SizedBox(height: 16),
              
              // Time Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                value: selectedTime,
                items: times.map((String time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedTime = newValue;
                },
              ),
              const SizedBox(height: 16),
              
              // Venue Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Venue',
                  border: OutlineInputBorder(),
                ),
                value: selectedVenue,
                items: venues.map((String venue) {
                  return DropdownMenuItem<String>(
                    value: venue,
                    child: Text(venue),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedVenue = newValue;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (selectedDay != null && selectedTime != null && selectedVenue != null) {
                  setState(() {
                    if (!courseSchedules.containsKey(courseName)) {
                      courseSchedules[courseName] = [];
                    }
                    courseSchedules[courseName]!.add({
                      'day': selectedDay!,
                      'time': selectedTime!,
                      'venue': selectedVenue!,
                    });
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select all fields')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _removeSchedule(String courseName, int index) {
    setState(() {
      courseSchedules[courseName]!.removeAt(index);
      if (courseSchedules[courseName]!.isEmpty) {
        courseSchedules.remove(courseName);
      }
    });
  }

  void _viewTimetable() {
    List<Map<String, String>> viewTimetable = [];
    
    courseSchedules.forEach((courseName, schedules) {
      for (var schedule in schedules) {
        viewTimetable.add({
          'course': courseName,
          'day': schedule['day']!,
          'time': schedule['time']!,
          'venue': schedule['venue']!,
        });
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Viewtimetablepage(timetable: viewTimetable),
      ),
    );
  }

  void _saveTimetable() {
    print("Saving Timetable...");
    for (var course in courses) {
      String courseName = course['course']!;
      List<Map<String, String>>? schedules = courseSchedules[courseName];
      
      print("$courseName:");
      if (schedules != null) {
        for (var schedule in schedules) {
          print("  - ${schedule['day']} at ${schedule['time']} in ${schedule['venue']}");
        }
      } else {
        print("  No schedules added");
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Timetable Saved Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Timetable',
          style: TextStyle(fontSize: 22,),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: _viewTimetable,
          ),
        ],
      ),
      body: Padding(  
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  String courseName = courses[index]['course']!;
                  List<Map<String, String>> schedules = courseSchedules[courseName] ?? [];
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Course Header with Add Button
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                courseName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF114367),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _addSchedule(courseName),
                                icon: const Icon(Icons.add, color: Colors.white),
                                label: const Text('Add Schedule', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF114367),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Schedules List
                        if (schedules.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'No schedules added yet',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: schedules.length,
                            itemBuilder: (context, scheduleIndex) {
                              final schedule = schedules[scheduleIndex];
                              
                              return ListTile(
                                leading: const Icon(Icons.schedule, color: Color(0xFF114367)),
                                title: Text(
                                  '${schedule['day']} at ${schedule['time']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(schedule['venue']!),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeSchedule(courseName, scheduleIndex),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _saveTimetable();
                    _viewTimetable();
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text('Save Timetable', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF114367),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Home is selected
        onTap: (index) {
          _navigateToAdminPage(context, index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _navigateToAdminPage(BuildContext context, int index) {
    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        break;
      case 1: // Registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        // Navigate to registration page
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseRegistrationPage(userType: 'Admin'),
            ),
          );
        });
        break;
      case 2: // Upload
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        // Navigate to upload page
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadPage(),
            ),
          );
        });
        break;
      case 3: // Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHome(userType: 'Admin'),
          ),
        );
        // Navigate to profile page
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(userType: 'Admin'),
            ),
          );
        });
        break;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
