// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/db_service.dart';
import '../widgets/chat_bubble.dart';
import '../services/ai_service.dart'; // new service for predefined QA

class ChatScreen extends StatefulWidget {
  final User user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  List<Map<String, dynamic>> chats = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  // Load previous chats for this user
  void _loadChats() async {
    final data = await DBService.getChats(widget.user.email); // email as key
    setState(() => chats = data);
  }

  // Send message and get response from predefined QA
  void _sendMessage() async {
    String msg = _controller.text.trim();
    if (msg.isEmpty) return;

    // Get response from AIService (predefined questions)
    String response = AIService.getResponse(msg);

    // Insert chat into database
    await DBService.insertChat(widget.user.email, msg, response);

    // Clear input and reload chats
    _controller.clear();
    _loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI ChatBot - ${widget.user.name}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login'); // logout
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: chats[index]['message'],
                  response: chats[index]['response'],
                );
              },
            ),
          ),

          // Input field + send button
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(onPressed: _sendMessage, icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
