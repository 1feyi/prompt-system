import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final String url = 'ws://localhost:3000'; // Update with your server URL
  final StreamController<dynamic> _messageController = StreamController<dynamic>.broadcast();
  bool _isConnected = false;

  // Listen for incoming messages
  Stream<dynamic> get messages => _messageController.stream;
  bool get isConnected => _isConnected;

  // Connect to WebSocket server
  void connect() {
    try {
    _channel = WebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;
      
      // Listen to incoming messages
      _channel!.stream.listen(
        (data) {
          _messageController.add(data);
        },
        onError: (error) {
          print('WebSocket error: $error');
          _isConnected = false;
        },
        onDone: () {
          print('WebSocket connection closed');
          _isConnected = false;
        },
      );
      
      print('WebSocket connected to $url');
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
      _isConnected = false;
    }
  }

  // Send messages to WebSocket server
  void sendMessage(String message) {
    if (_channel != null && _isConnected) {
      try {
      _channel!.sink.add(message);
        print('Sent message: $message');
      } catch (e) {
        print('Failed to send message: $e');
      }
    } else {
      print('WebSocket not connected');
    }
  }

  // Close the connection
  void close() {
    _channel?.sink.close();
    _messageController.close();
    _isConnected = false;
  }
}
