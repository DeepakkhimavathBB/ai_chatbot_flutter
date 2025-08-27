import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../models/user.dart';

class TaskScreen extends StatefulWidget {
  final User user;
  const TaskScreen({super.key, required this.user});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    var data = TaskService.getTasks();
    setState(() => tasks = data);
  }

  void _addTask() async {
    TextEditingController controller = TextEditingController();
    DateTime? selectedTime;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Task title'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text(
                  selectedTime == null
                      ? 'Set Reminder'
                      : 'Reminder: ${selectedTime.toString().substring(0, 16)}',
                ),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      selectedTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                      setState(() {});
                    }
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isNotEmpty) {
                  Task newTask = Task(
                    title: controller.text.trim(),
                    reminderTime: selectedTime,
                  );
                  await TaskService.addTask(newTask);
                  _loadTasks();
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDone(Task task) async {
    await TaskService.toggleDone(task);
    _loadTasks();
  }

  void _deleteTask(Task task) async {
    await TaskService.deleteTask(task);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Planner')),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet! Add a task using + button.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: task.reminderTime != null
                        ? Text('Reminder: ${task.reminderTime.toString().substring(0, 16)}')
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (task.reminderTime != null) Icon(Icons.alarm),
                        Checkbox(value: task.isDone, onChanged: (_) => _toggleDone(task)),
                        IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteTask(task)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTask,
      ),
    );
  }
}
