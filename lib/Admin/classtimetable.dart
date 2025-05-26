import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/viewtimetablepage.dart';

class ClassTimetablesPage extends StatefulWidget {
  const ClassTimetablesPage({super.key});

  @override
  State <ClassTimetablesPage> createState() => _ClassTimetablesPageState();
}

class _ClassTimetablesPageState extends State<ClassTimetablesPage> {
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
   

  final List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
  ];

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
        title: const Text('Class Timetable',
        style: TextStyle(fontSize: 22,),),
        leading: IconButton(
        icon:const Icon( Icons.arrow_back),
        onPressed:(){
          Navigator.pop(context);
        },
      )),
      
      body: Padding(  
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            // Header Row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
              color: const Color(0xFF114367),
              child: const Row(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text('Course', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  Expanded(child: Text('Day', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  Expanded(child:Text('Time', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  Expanded(child: Text('Venue', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  
                ],
              ),
            ),
            const SizedBox(height: 10),

            // List of Courses with Inputs
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
                        // Course Name
                        Expanded(child: Text(courseName)),

                        // Day Dropdown
                        Expanded(
                          child: DropdownButton<String>(
                            value: selectedDays[courseName],
                            hint: const Text(' Day'),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDays[courseName] = newValue!;
                              });
                            },
                            items: daysOfWeek.map((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day, style: const TextStyle(fontSize: 14.0),),
                              );
                            }).toList(),
                          ),
                        ),

                        //Time dropdown 
                        Expanded(
                          child: DropdownButton<String>(
                            value: selectedTimes[courseName],
                            hint: const Text(' Time'),
                            isExpanded: true,
                            onChanged: (String? newValue){
                              setState(() {
                                 selectedTimes[courseName] = newValue!;
                              });
                            },
                            items: times.map((String time){
                              return DropdownMenuItem(
                              value: time,
                              child: Text(time, style: const TextStyle(fontSize: 14.0)),
                              );
                            }

                            ).toList()

                          ),),

                        // Venue dropdown
                        Expanded(
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
                          )
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // Submit Button
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      _saveTimetable();
                      Navigator.push(context,
                       MaterialPageRoute(builder: (context)=>const Viewtimetablepage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF114367),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: const Text(
                      'Save Timetable',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
               const SizedBox(height: 350), // Adds space below button


                 // Viewtimetable buttton 
                 ElevatedButton(onPressed: (){
                    Navigator.push(context,
                       MaterialPageRoute(builder: (context)=>const Viewtimetablepage()));
                 },
                 style:ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: const Color(0xFF114367),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                 ),
                 child: const Text('View Timetable',
                  style: TextStyle(color: Colors.white),),
                 ),
                 const SizedBox(height: 220,)

              ],

            ),
          ],
        ),
      ),
    );
  }

  // Function to Save Timetable
  void _saveTimetable() {
    print("Saving Timetable...");
    for (var course in courses) {
      String courseName = course['course']!;
      String? selectedDay = selectedDays[courseName];
      String? selectedTime = selectedTimes[courseName];
      String? selectedVenue = selectedVenues[courseName];

      print("$courseName - Day: ${selectedDay ?? 'Not selected'}, Time: ${selectedTimes ?? 'Not Selected'}, Venue: ${selectedVenues ?? 'Not entered'}");
    }

    // Show Success Message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Timetable Saved Successfully!")),
    );
  }
}