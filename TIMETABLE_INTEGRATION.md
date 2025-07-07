# Timetable Integration Documentation

## Overview
This document describes the integration between the admin timetable management and student timetable viewing functionality. The system now uses a backend API to store and retrieve timetable data, ensuring that when an admin saves a timetable, it automatically appears in student views.

## Backend API Endpoints

### Base URL
```
https://eca7-105-113-57-185.ngrok-free.app/api
```

### Timetable Endpoints

#### GET /timetable
- **Purpose**: Fetch all timetable entries
- **Response**: Array of timetable objects
- **Status**: 200 OK

#### POST /timetable
- **Purpose**: Create a new timetable entry
- **Body**: 
  ```json
  {
    "course": "CSC 101",
    "day": "Monday",
    "time": "9:00 AM",
    "venue": "COCCS LAB"
  }
  ```
- **Response**: Created timetable object
- **Status**: 201 Created

#### DELETE /timetable/:id
- **Purpose**: Delete a specific timetable entry
- **Response**: Success message
- **Status**: 200 OK

## Flutter Implementation

### TimetableService
Located at: `lib/services/timetable_service.dart`

This service handles all API communication for timetable operations:

- `fetchTimetable()`: Retrieves all timetable entries from backend
- `saveTimetableEntry()`: Saves a new timetable entry to backend
- `deleteTimetableEntry()`: Deletes a timetable entry from backend

### Admin Flow

1. **Class Timetable Page** (`lib/Admin/class_timetable.dart`)
   - Admin can add schedules for each course
   - Each schedule is immediately saved to the backend
   - Admin can view the complete timetable
   - Loading states and error handling included

2. **View Timetable Page** (`lib/Admin/view_timetable_page.dart`)
   - Displays all timetable entries from backend
   - Refresh button to reload data
   - Loading indicator while fetching data

### Student Flow

1. **Student Home Page** (`lib/screens/user/user_home.dart`)
   - Next class information is fetched from backend
   - Real-time countdown to next class
   - Timetable card navigates to student timetable view

2. **Student Timetable View** (`lib/Student/student_timetable_view.dart`)
   - Displays all timetable entries from backend
   - Grouped by day for easy reading
   - Refresh button to reload data
   - Loading indicator while fetching data

3. **Student Homepage** (`lib/Student/studenthomepage.dart`)
   - Timetable card navigates to student timetable view
   - No longer uses hardcoded data

## Data Flow

1. **Admin creates timetable**:
   - Admin adds schedule in Class Timetable page
   - Data is sent to backend via POST request
   - Success/error feedback shown to admin

2. **Admin views timetable**:
   - View Timetable page fetches data from backend
   - Displays all saved entries

3. **Student views timetable**:
   - Student Timetable View fetches same data from backend
   - Displays identical information as admin view
   - Real-time updates when admin makes changes

4. **Student dashboard**:
   - Next class information calculated from backend data
   - Countdown timer updates automatically

## Error Handling

- Network errors are caught and displayed to users
- Loading states prevent UI issues during API calls
- Fallback messages when data cannot be loaded
- Retry mechanisms (refresh buttons) for failed requests

## Testing

To test the backend connection, run:
```bash
dart run test_backend_connection.dart
```

This will test both GET and POST endpoints and verify the connection is working.

## Benefits

1. **Real-time synchronization**: Changes made by admin immediately appear to students
2. **Centralized data**: All timetable data stored in one place
3. **Scalability**: Easy to add more features like timetable conflicts, room availability, etc.
4. **Reliability**: Proper error handling and loading states
5. **Maintainability**: Clean separation of concerns with dedicated service

## Future Enhancements

- WebSocket integration for real-time updates
- Timetable conflict detection
- Room availability checking
- Bulk timetable import/export
- Timetable versioning
- Notification system for timetable changes 