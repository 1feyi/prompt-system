import 'package:flutter/material.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';
import 'package:prompt_system/Admin/registration_page.dart';
import 'package:prompt_system/Admin/upload_page.dart';
import 'package:prompt_system/screens/admin/profile_page.dart';

class Exampage extends StatefulWidget {
  const Exampage({super.key});

  @override
  _ExampageState createState() => _ExampageState();
}

class _ExampageState extends State<Exampage> {
  final List<Map<String, String>> courses = [
    {'course': 'CSC 101'},
    {'course': 'MTH 102'},
    {'course': 'PHY 103'},
    {'course': 'CHM 104'},
    {'course': 'ENG 105'},
  ];

  final Map<String, String> selectedDays = {};
   final Map<String, String> selectedTimes = {};
  final Map<String, String> selectedVenues = {};
   
  final List <String> times = [
    '8:00AM', '9:00AM', '10:00AM', '11:00AM', '12:00PM', '1:00PM', '2:00PM', '3:00PM', '4:00PM','5:00PM', 
  ];

  final List <String> venues = [
    'CALT', 'COLAW', 'SMS', 'ALMA ROHM', 'NEW HORIZON', 'CHM BUILDING', 'COCCS',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Timetable',
         style: TextStyle(fontSize: 25,),),
        leading: IconButton(
        icon: const Icon( Icons.arrow_back),
        onPressed:(){
          Navigator.pop(context);
        },
      
         ),
        ),
      
      body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            //  Row (course, day, time, venue)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
              color:const Color(0xFF114367),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Align(alignment: Alignment.centerLeft, child:  Text('Course', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                  Expanded(child: Align(alignment: Alignment.centerLeft, child: Text('Day', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                  Expanded(child:Align(alignment: Alignment.centerLeft,child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                  Expanded(child: Align(alignment: Alignment.centerLeft,child: Text('Venue', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // List of Courses 
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  String courseName = courses[index]['course']!;
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                    ),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         // Course Name Column
                        Expanded(
                          child: 
                          Text(courseName,
                          style: const TextStyle(fontSize: 14),)),           
                    
                      // Date Column 
                     Expanded(
                      child: 
                       TextButton(
                        style: TextButton.styleFrom(
                       alignment: Alignment.centerLeft,
                       padding: EdgeInsets.zero,
                        ),
                        onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2030),
                        );
                           if (pickedDate != null) {
                             setState(() {
                                selectedDays[courseName] =
                                 "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                     });
                                    }
                                  },
                        
                       child: Text(
                         selectedDays[courseName] ?? 'Date',
                         style: const TextStyle(color: Color(0xFF114367), fontSize: 14),
                          overflow: TextOverflow.ellipsis, // Prevent overflow
                           ),
                          ),
                        
                       ),

                        //Time Column
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton<String>(
                              value: selectedTimes[courseName],
                              hint: const Text('Time',style: TextStyle(fontSize: 14)),
                              isExpanded: true,
                              onChanged: (String? newValue){
                                setState(() {
                                   selectedTimes[courseName] = newValue!;
                                });
                              },
                              items: times.map((String time){
                                return DropdownMenuItem(
                                value: time,
                                child: Text(time, style: const TextStyle(fontSize: 14)),
                                );
                              }
                            
                              ).toList()
                            
                            ),
                          ),),

                          // Venue Column 
                          Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton<String>(
                              value: selectedVenues[courseName],
                              hint: const Text('Venue', style: TextStyle(fontSize: 14)),
                              isExpanded: true,
                              onChanged: (String? newValue){
                                setState(() {
                                   selectedVenues[courseName] = newValue!;
                                });
                              },
                              items: venues.map((String venue){
                                return DropdownMenuItem(
                                value: venue,
                                child: Text(venue,style: const TextStyle(fontSize: 13)),
                                );
                              }
                            
                              ).toList()
                            
                            ),
                          ),),
                      
             
                    ]
                    )
                  );
                },
              ),
            ),
 

            // Submit Button
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0), 
              child: ElevatedButton(
                onPressed: () {
                  _saveTimetable();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114367),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: const Text(
                  'Save Timetable',
                  style: TextStyle(color: Colors.white,
                  fontSize: 17),
                ),
              ),
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

  // Function to Save Timetable
  void _saveTimetable() {
    print("Saving Timetable...");
    for (var course in courses) {
      String courseName = course['course']!;
      String? selectedDay = selectedDays[courseName];
      String? selectedTime = selectedTimes[courseName];
      String? selectedVenue = selectedVenues[courseName];

      print("$courseName - Day: ${selectedDay ?? 'Not selected'}, Time: ${selectedTime ?? 'Not Selected'}, Venue: ${selectedVenue ?? 'Not entered'}");
    }

    // Show Success Message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Timetable Saved Successfully!")),
    );
  }
}