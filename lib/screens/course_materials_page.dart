import 'package:flutter/material.dart';

class CourseMaterialsPage extends StatefulWidget {
  const CourseMaterialsPage({super.key});

  @override
  State<CourseMaterialsPage> createState() => _CourseMaterialsPageState();
}

class _CourseMaterialsPageState extends State<CourseMaterialsPage> {
  // Example course materials data - this would come from a database in a real app
  final List<Map<String, dynamic>> courses = [
    {
      'code': 'CSC 101',
      'title': 'Introduction to Computer Science',
      'materials': [
        {
          'title': 'Course Syllabus',
          'type': 'PDF',
          'size': '2.5 MB',
          'uploadDate': '2024-03-15',
        },
        {
          'title': 'Week 1 Lecture Notes',
          'type': 'PDF',
          'size': '1.8 MB',
          'uploadDate': '2024-03-16',
        },
        {
          'title': 'Programming Assignment 1',
          'type': 'DOC',
          'size': '500 KB',
          'uploadDate': '2024-03-17',
        },
      ],
    },
    {
      'code': 'MTH 102',
      'title': 'Calculus I',
      'materials': [
        {
          'title': 'Course Outline',
          'type': 'PDF',
          'size': '1.2 MB',
          'uploadDate': '2024-03-15',
        },
        {
          'title': 'Chapter 1 Notes',
          'type': 'PDF',
          'size': '3.1 MB',
          'uploadDate': '2024-03-16',
        },
      ],
    },
    {
      'code': 'PHY 103',
      'title': 'Physics for Engineers',
      'materials': [
        {
          'title': 'Course Handbook',
          'type': 'PDF',
          'size': '4.2 MB',
          'uploadDate': '2024-03-15',
        },
        {
          'title': 'Lab Manual',
          'type': 'PDF',
          'size': '2.8 MB',
          'uploadDate': '2024-03-16',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Materials',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(
                course['code'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF114367),
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text(
                course['title'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
              children: [
                if (course['materials'].isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'No materials available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: course['materials'].length,
                    itemBuilder: (context, materialIndex) {
                      final material = course['materials'][materialIndex];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                              width: materialIndex == course['materials'].length - 1 ? 0 : 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Material Icon
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(25, 17, 67, 103),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _getMaterialIcon(material['type']),
                                color: const Color(0xFF114367),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Material Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    material['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        material['type'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        material['size'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Download Button
                            IconButton(
                              icon: const Icon(Icons.download),
                              color: const Color(0xFF114367),
                              onPressed: () {
                                // TODO: Implement download functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Downloading ${material['title']}...'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getMaterialIcon(String type) {
    switch (type.toUpperCase()) {
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'DOC':
      case 'DOCX':
        return Icons.description;
      case 'PPT':
      case 'PPTX':
        return Icons.slideshow;
      case 'XLS':
      case 'XLSX':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file;
    }
  }
} 