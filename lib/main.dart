import 'package:flutter/material.dart';
//import 'package:prompt_system/provider/courseprovider.dart';
//import 'package:provider/provider.dart';
import 'authentication screens/splashscreen.dart';

void main() {
  runApp(
    //ChangeNotifierProvider(
    //  create: (context) => CourseProvider(),
      //child: const MyApp(),
   // ),
   const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const SplashScreen()
    );
  }
}
