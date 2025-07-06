# Announcement System Setup Guide

## Overview
The announcement system uses WebSocket to provide real-time communication between admin and students. When an admin sends an announcement, it's broadcast to all connected students instantly.

## Setup Instructions

### 1. Install WebSocket Server Dependencies
```bash
npm install
```

### 2. Start the WebSocket Server
```bash
npm start
```
or
```bash
node test_websocket_server.js
```

You should see: "WebSocket server started on port 3000"

### 3. Test the System

#### Step 1: Start the Flutter App
Run your Flutter app and navigate to the student dashboard.

#### Step 2: Check Announcements
- Go to the "Announcements" tab in the student dashboard
- You should see sample announcements (green dot indicator shows connection status)
- The number next to the dot shows total announcements

#### Step 3: Send Test Announcement (Admin)
- Login as admin
- Go to "Send Announcement"
- Select a course and enter a message
- Click "Send Announcement"

#### Step 4: Verify Real-time Delivery
- The announcement should appear immediately in the student's announcement list
- Check the console logs for WebSocket messages

## Troubleshooting

### Connection Issues
1. **Check WebSocket URL**: Ensure `ws://localhost:3000` in `websocket_service.dart`
2. **Server Running**: Verify the Node.js server is running on port 3000
3. **Firewall**: Make sure port 3000 is not blocked

### No Announcements Displaying
1. **Check Console Logs**: Look for WebSocket connection messages
2. **Provider Initialization**: Verify `AnnouncementProvider` is in your `main.dart`
3. **Sample Data**: Check if sample announcements are being added

### Debug Information
- Green dot in announcements page = connected with data
- Grey dot = no data or connection issue
- Number shows total announcements
- Check Flutter console for WebSocket logs

## Expected Behavior
1. Admin sends announcement → WebSocket broadcasts to all clients
2. Students receive announcement instantly
3. Announcements appear in both "All Messages" and "Unread" tabs
4. Tapping an announcement marks it as read

## File Structure
```
lib/
├── services/websocket_service.dart      # WebSocket connection
├── providers/announcement_provider.dart  # State management
├── Admin/announcement_page.dart         # Admin send interface
└── screens/user/user_home.dart          # Student display
``` 