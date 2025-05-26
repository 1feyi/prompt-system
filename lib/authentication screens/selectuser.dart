import 'package:flutter/material.dart';

import 'signupdetails.dart';
import 'emailpassword.dart';

class Selectuser extends StatelessWidget {
  const Selectuser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [

          Positioned(
            top: -51, 
            left: 100.5,
            child: Container(
              width: 290.5,
              height: 288.84,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200),
                  bottomRight: Radius.circular(80),
                ),
                
                color: const Color(0xFF114367).withAlpha(36),
                                
                ),
               

              )
            ),

        
    // Main content 
      
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Create Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30, 
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color:  Color(0xFF114367), 
              ),
              ),
            const Text(
              "Let's get you started",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17, 
                color: Color.fromARGB(255, 126, 126, 126), 
              ),
              ),

          // Register as Admin Button 
            const SizedBox(
              height: 56,
              width: 344, 
              ),
            ElevatedButton(
              onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> SignUpDetailsScreen(userType:"Admin")),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(344, 56) ,
               backgroundColor: const Color(0xFF114367),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          // Admin Text 
            child: const Text(
              "Register as Admin",
                style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 17,
               ), 
              ),
            
            ),
            
            // Register as Student Button
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>SignUpDetailsScreen(userType:"Student")),
                  );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(344, 56) ,
                backgroundColor: const Color(0xFF114367),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                
              ),
            ),

            // Student text 
              child: const Text(
                "Register as Student",
               style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 17,

               ), 
              )),
              const SizedBox(height: 21,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmailPasswordScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF114367)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Already have an account? log in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF114367),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
          ],
        
        ),
      ),
      ],
      ),
      
    );
  }
}