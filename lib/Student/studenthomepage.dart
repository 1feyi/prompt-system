import 'package:flutter/material.dart';

class Studenthomepage extends StatelessWidget {
  final String userName;
  const Studenthomepage({super.key, required this.userName, required String userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CLASS SCHEDULE",
      style:TextStyle(
         fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color:  Color(0xFF114367),
      ) ),),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi $userName,"
          ),

//Next schedule Container 
        Container(
          width: double.infinity,
          height: 140,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),

// Text in Next schedule container 
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Text("Next Schedule",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color:  Color(0xFF114367),

            ),
            ),

           ],
          ),
        ),
        const SizedBox(height: 25,),
        Expanded(child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          children: [
            _buildClickableCard(context, "Timetable", Icons.schedule),
            _buildClickableCard(context, "Assignments", Icons.assignment),
            _buildClickableCard(context, "Test", Icons.quiz),
            _buildClickableCard(context, "Exam", Icons.school)
          ],
          
          ))


      ],) ,

      ),
    );
   
  }
}

Widget _buildClickableCard(BuildContext context, String title, IconData icon) {
  return GestureDetector(
    onTap: (){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text("$title Clicked!"))
        );
    },
    child: Container(
      decoration: BoxDecoration(
        color:const Color(0xFF114367),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size:50),
             const SizedBox(height: 10),
             Text(
              title,
              style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
             )

      ],),
    )
  );
}

