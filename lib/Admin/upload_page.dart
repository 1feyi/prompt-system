import 'package:flutter/material.dart';
import 'package:prompt_system/screens/admin/admin_home.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Files', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF114367))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminHome(userType: 'admin'),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Upload your files here',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'Poppins', color: Color(0xFF114367)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement file upload logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File upload functionality to be implemented')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF114367),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Choose File', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
            ),
          ],
        ),
      ),
    );
  }
}
