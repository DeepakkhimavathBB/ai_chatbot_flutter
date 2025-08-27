// lib/screens/service_screen.dart
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'alarm_screen.dart';
import 'task_screen.dart';
import '../models/user.dart';

class ServiceScreen extends StatelessWidget {
  final User user;
  const ServiceScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services - ${user.name}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.chat),
              label: Text('AI ChatBot'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatScreen(user: user)),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.alarm),
              label: Text('Set Alarm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AlarmScreen(user: user)),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.task),
              label: Text('Task Planner'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TaskScreen(user: user)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
