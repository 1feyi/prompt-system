import 'package:flutter/material.dart';
import '../models/assignment.dart';

class StudentAssignmentsView extends StatefulWidget {
  const StudentAssignmentsView({super.key});

  @override
  State<StudentAssignmentsView> createState() => _StudentAssignmentsViewState();
}

class _StudentAssignmentsViewState extends State<StudentAssignmentsView> {
  List<Assignment> assignments = [];
  String currentFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  void _loadAssignments() {
    // TODO: Load from actual storage
    // For now, using example data
    setState(() {
      assignments = [
        Assignment(
          course: 'CSC 101',
          title: 'Introduction to Programming',
          description: 'Create a simple calculator program using Python',
          dueDate: DateTime(2024, 4, 15),
          dueTime: '11:59 PM',
        ),
        Assignment(
          course: 'MTH 102',
          title: 'Calculus Assignment',
          description: 'Solve the following differential equations',
          dueDate: DateTime(2024, 4, 10),
          dueTime: '11:59 PM',
        )..markAsComplete(),
        Assignment(
          course: 'PHY 103',
          title: 'Physics Lab Report',
          description: 'Write a report on the pendulum experiment',
          dueDate: DateTime(2024, 4, 5),
          dueTime: '11:59 PM',
        )..checkOverdue(),
      ];
    });
  }

  void _markAsComplete(Assignment assignment) {
    setState(() {
      assignment.markAsComplete();
    });
  }

  List<Assignment> get filteredAssignments {
    switch (currentFilter) {
      case 'pending':
        return assignments.where((a) => a.status == 'pending').toList();
      case 'completed':
        return assignments.where((a) => a.status == 'completed').toList();
      case 'overdue':
        return assignments.where((a) => a.status == 'overdue').toList();
      default:
        return assignments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          ),
        ),
      ),
      body: Column(
        children: [
          // Status Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildStatusTab(context, 'All', assignments.length, 'all'),
                const SizedBox(width: 8),
                _buildStatusTab(context, 'Pending', assignments.where((a) => a.status == 'pending').length, 'pending'),
                const SizedBox(width: 8),
                _buildStatusTab(context, 'Completed', assignments.where((a) => a.status == 'completed').length, 'completed'),
                const SizedBox(width: 8),
                _buildStatusTab(context, 'Overdue', assignments.where((a) => a.status == 'overdue').length, 'overdue'),
              ],
            ),
          ),
          
          // Assignment Cards
          Expanded(
            child: filteredAssignments.isEmpty
                ? Center(
                    child: Text(
                      'No ${currentFilter == 'all' ? '' : currentFilter} assignments',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = filteredAssignments[index];
                      return _buildAssignmentCard(context, assignment);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTab(BuildContext context, String status, int count, String filter) {
    final isSelected = currentFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF114367) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              status,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: isSelected ? const Color(0xFF114367) : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(BuildContext context, Assignment assignment) {
    Color statusColor;
    switch (assignment.status) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'overdue':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showAssignmentDetails(context, assignment),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      assignment.course,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF114367),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(25, statusColor.red, statusColor.green, statusColor.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      assignment.status.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                assignment.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Due: ${assignment.dueDate.toString().split(' ')[0]} at ${assignment.dueTime}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAssignmentDetails(BuildContext context, Assignment assignment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        assignment.course,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF114367),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Title
                const Text(
                  'Assignment Title',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  assignment.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Description
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  assignment.description,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Due Date
                const Text(
                  'Due Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${assignment.dueDate.toString().split(' ')[0]} at ${assignment.dueTime}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Action Buttons
                if (assignment.status == 'pending')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _markAsComplete(assignment);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF114367),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Mark as Complete',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 