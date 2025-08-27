import 'package:hive/hive.dart';
import '../models/task.dart';
import 'notification_service.dart';

class TaskService {
  static const String boxName = 'tasksBox';

  static Box<Task> get _box => Hive.box<Task>(boxName);

  static Future<void> addTask(Task task) async {
    await _box.add(task);

    if (task.reminderTime != null) {
      await NotificationService.scheduleAlarm(
        task.key,
        'Task Reminder',
        task.title,
        task.reminderTime!,
      );
    }
  }

  static List<Task> getTasks() {
    return _box.values.toList();
  }

  static Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  static Future<void> toggleDone(Task task) async {
    task.isDone = !task.isDone;
    await task.save();
  }
}
