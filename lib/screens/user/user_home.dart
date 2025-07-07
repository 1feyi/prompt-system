import 'package:flutter/material.dart';
import 'package:prompt_system/Admin/assignment_page.dart';
import 'package:prompt_system/Admin/registration_page.dart';
import 'package:prompt_system/Admin/notifications_page.dart';
import 'package:prompt_system/Admin/test_page.dart';
import 'package:prompt_system/Admin/exam_page.dart';
import 'package:prompt_system/Student/student_assignments_view.dart';
import 'package:prompt_system/Student/student_tests_view.dart';
import 'package:prompt_system/Student/student_exams_view.dart';
import 'package:prompt_system/Student/student_timetable_view.dart';
import 'package:prompt_system/provider/user_provider.dart';
import 'package:prompt_system/screens/course_materials_page.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:prompt_system/providers/announcement_provider.dart';
import 'package:prompt_system/services/timetable_service.dart';


class UserHome extends StatefulWidget {
  final String userType;
  final String userName;
  const UserHome({super.key, required this.userType, required this.userName});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      UserDashboard(userName: widget.userName),
      const CourseMaterialsPage(),
      const AnnouncementsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return;
        }
        
        // Show exit confirmation dialog
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit App',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF114367),
              ),
            ),
            content: const Text(
              'Are you sure you want to exit the app?',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Color(0xFF114367),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Color(0xFF114367),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        );
        
        if (shouldPop ?? false) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF114367),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Materials',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement),
              label: 'Announcements',
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages for the new navigation items
class CourseMaterialsPage extends StatelessWidget {
  const CourseMaterialsPage({super.key});

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
            // Find the nearest UserHome widget and update its state
            final userHomeState = context.findAncestorStateOfType<_UserHomeState>();
            if (userHomeState != null) {
              userHomeState.setState(() {
                userHomeState._selectedIndex = 0;
              });
            }
          },
        ),
      ),
      body: const Center(
        child: Text('Course Materials Page'),
      ),
    );
  }
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Initialize announcements and add sample data for testing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AnnouncementProvider>(context, listen: false);
      provider.addSampleAnnouncements();
      print('Announcements initialized. Total: ${provider.allAnnouncements.length}');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final userHomeState = context.findAncestorStateOfType<_UserHomeState>();
            if (userHomeState != null) {
              userHomeState.setState(() {
                userHomeState._selectedIndex = 0;
              });
            }
          },
        ),
        actions: [
          // Connection status indicator
          Consumer<AnnouncementProvider>(
            builder: (context, provider, child) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: provider.allAnnouncements.isNotEmpty ? Colors.green : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${provider.allAnnouncements.length}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF114367),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF114367),
          tabs: const [
            Tab(text: 'All Messages'),
            Tab(text: 'Unread'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAnnouncementsList(context, false),
          _buildAnnouncementsList(context, true),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsList(BuildContext context, bool unreadOnly) {
    return Consumer<AnnouncementProvider>(
      builder: (context, provider, child) {
        final announcements = unreadOnly 
            ? provider.unreadAnnouncements 
            : provider.allAnnouncements;

        if (announcements.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  unreadOnly ? Icons.mark_email_unread : Icons.announcement,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  unreadOnly ? 'No unread messages' : 'No announcements yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  if (!announcement.isRead) {
                    provider.markAsRead(announcement.id);
                  }
                  _showAnnouncementDetails(context, announcement);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: announcement.isRead ? Colors.grey : const Color(0xFF114367),
                        width: 4,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            announcement.course,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF114367),
                            ),
                          ),
                          if (!announcement.isRead)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(red: 255, green: 255, blue: 255, alpha: 51),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'New',
                                style: TextStyle(
                                  color: Color(0xFF114367),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        announcement.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatTimestamp(announcement.timestamp),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAnnouncementDetails(BuildContext context, Announcement announcement) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        announcement.course,
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
                Text(
                  announcement.message,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Posted on ${_formatTimestamp(announcement.timestamp)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

class UserDashboard extends StatefulWidget {
  final String userName;
  const UserDashboard({super.key, required this.userName});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String _nextClassInfo = '';
  String _countdown = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateNextClass();
    // Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateNextClass();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateNextClass() async {
    final now = DateTime.now();
    final currentDay = _getDayName(now.weekday);
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    try {
      // Fetch timetable data from backend
      final List<Map<String, dynamic>> timetableData = await TimetableService.fetchTimetable();

    // Find the next class
    Map<String, dynamic>? nextClass;
    DateTime? nextClassTime;

    // First, try to find a class for today
    for (var entry in timetableData) {
      if (entry['day'] == currentDay) {
        final classTime = _parseTime(entry['time']);
        if (classTime.isAfter(now)) {
          if (nextClass == null || classTime.isBefore(nextClassTime!)) {
            nextClass = entry;
            nextClassTime = classTime;
          }
        }
      }
    }

    // If no classes found for today, look for the first class tomorrow
    if (nextClass == null) {
      final tomorrow = now.add(const Duration(days: 1));
      final tomorrowDay = _getDayName(tomorrow.weekday);
      
      // Only look for tomorrow's classes if it's a weekday (Monday to Friday)
      if (tomorrow.weekday >= DateTime.monday && tomorrow.weekday <= DateTime.friday) {
        for (var entry in timetableData) {
          if (entry['day'] == tomorrowDay) {
            final classTime = _parseTime(entry['time']);
            // Set the time to tomorrow
            final tomorrowClassTime = DateTime(
              tomorrow.year,
              tomorrow.month,
              tomorrow.day,
              classTime.hour,
              classTime.minute,
            );
            
            if (nextClass == null || tomorrowClassTime.isBefore(nextClassTime!)) {
              nextClass = entry;
              nextClassTime = tomorrowClassTime;
            }
          }
        }
      }
    }

    if (nextClass != null) {
      final timeUntil = nextClassTime!.difference(now);
      final hours = timeUntil.inHours;
      final minutes = timeUntil.inMinutes.remainder(60);
      final seconds = timeUntil.inSeconds.remainder(60);

      setState(() {
        _nextClassInfo = '${nextClass!['course']} at ${nextClass!['time']} in ${nextClass!['venue']}';
        _countdown = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    } else {
      setState(() {
        _nextClassInfo = 'No more classes scheduled';
        _countdown = '';
      });
    }
    } catch (e) {
      print('Error updating next class: $e');
      setState(() {
        _nextClassInfo = 'Error loading timetable';
        _countdown = '';
      });
    }
  }

  DateTime _parseTime(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(' ');
    final timeParts = parts[0].split(':');
    var hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    
    if (parts[1] == 'PM' && hour != 12) hour += 12;
    if (parts[1] == 'AM' && hour == 12) hour = 0;

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  Widget _buildClickableCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () async {
        switch (title) {
          case "Timetable":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentTimetableView(),
              ),
            );
            break;
          case "Assignments":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentAssignmentsView()),
            );
            break;
          case "Test":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentTestsView(),
              ),
            );
            break;
          case "Exam":
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentExamsView(),
              ),
            );
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF114367),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CLASS SCHEDULE",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF114367),
          )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi ${widget.userName},",
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                color: Color(0xFF114367),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF114367), Color(0xFF1A5A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Next Schedule",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _nextClassInfo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  if (_countdown.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Time remaining: $_countdown',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                children: [
                  _buildClickableCard(context, "Timetable", Icons.schedule, const SizedBox()),
                  _buildClickableCard(context, "Assignments", Icons.assignment, const StudentAssignmentsView()),
                  _buildClickableCard(context, "Test", Icons.quiz, const StudentTestsView()),
                  _buildClickableCard(context, "Exam", Icons.school, const StudentExamsView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 