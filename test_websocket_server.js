const WebSocket = require('ws');

// Create WebSocket server
const wss = new WebSocket.Server({ port: 3000 });

console.log('WebSocket server started on port 3000');

// Store connected clients
const clients = new Set();

wss.on('connection', (ws) => {
  console.log('New client connected');
  clients.add(ws);

  // Handle incoming messages
  ws.on('message', (message) => {
    try {
      const data = JSON.parse(message);
      console.log('Received message:', data);

      if (data.type === 'announcement') {
        // Broadcast announcement to all connected clients
        const broadcastMessage = JSON.stringify({
          type: 'announcement',
          course: data.course,
          message: data.message,
          timestamp: data.timestamp || new Date().toISOString(),
        });

        clients.forEach((client) => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(broadcastMessage);
            console.log('Broadcasted announcement to client');
          }
        });
      }
    } catch (error) {
      console.error('Error processing message:', error);
    }
  });

  // Handle client disconnection
  ws.on('close', () => {
    console.log('Client disconnected');
    clients.delete(ws);
  });

  // Handle errors
  ws.on('error', (error) => {
    console.error('WebSocket error:', error);
    clients.delete(ws);
  });

  // Send welcome message
  ws.send(JSON.stringify({
    type: 'connection',
    message: 'Connected to announcement server'
  }));
});

// Handle server shutdown
process.on('SIGINT', () => {
  console.log('Shutting down WebSocket server...');
  wss.close();
  process.exit(0);
}); 