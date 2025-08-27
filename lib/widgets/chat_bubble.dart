// lib/widgets/chat_bubble.dart
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String response;

  const ChatBubble({super.key, required this.message, required this.response});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10)),
              child: Text(message)),
          SizedBox(height: 5),
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(10)),
              child: Text(response)),
        ],
      ),
    );
  }
}
