import 'package:flutter/material.dart';


class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final List<Map<String, String>> courses = [
    {'course': 'CSC 101'},
    {'course': 'MTH 102'},
    {'course': 'PHY 103'},
    {'course': 'CHM 104'},
    {'course': 'ENG 105'},
  ];

  String? selectedCourse;
  final TextEditingController messageController = TextEditingController();

  void sendAnnouncement() {
    if (selectedCourse == null || messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all fields"),
          duration: Duration (seconds: 2),),

      );
      return;
    }
    // show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Announcement sent for $selectedCourse"),
      duration: const Duration (seconds: 1),
      ),
    );
    // Delay, then navigate back to previous screen (home)
  Future.delayed(const Duration(seconds: 1), () {
    Navigator.pop(context); // Pop back to home
  });

    // Clear input field after sending
    setState(() {
      selectedCourse = null;
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text("Send Announcement"),
        leading: IconButton(
        icon:const Icon( Icons.arrow_back),
        onPressed:(){
          Navigator.pop(context);
        },

        )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Course",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
              ),
              const SizedBox(height: 8),

              // Course Selection Dropdown
              DropdownButtonFormField<String>(
                value: selectedCourse,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                hint: const Text("Choose a course"),
                items: courses.map((course) {
                  return DropdownMenuItem(
                    value: course['course'],
                    child: Text(course['course']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Message Input Field
              const Text(
                "Enter Announcement Message",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Enter your announcement here...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 20),

              // Send Button
              SizedBox(
                width: double.infinity, // Full-width button
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text("Send Announcement",
                  style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    backgroundColor:  const Color(0xFF114367), 
                  ),
                  onPressed: sendAnnouncement,
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}