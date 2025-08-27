import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/notification_service.dart';

class AlarmScreen extends StatefulWidget {
  final User user;
  const AlarmScreen({super.key, required this.user});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    NotificationService.init(); // initialize notification service
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => _selectedTime = time);

      final now = DateTime.now();
      DateTime alarmDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      // If selected time is before now, schedule for next day
      if (alarmDateTime.isBefore(now)) {
        alarmDateTime = alarmDateTime.add(Duration(days: 1));
      }

      await NotificationService.scheduleAlarm(
        0,
        'Alarm',
        'Your alarm is ringing!',
        alarmDateTime,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alarm set for ${time.format(context)}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Alarm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedTime == null
                  ? 'No Alarm Set'
                  : 'Alarm set at: ${_selectedTime!.format(context)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text('Pick Time', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
