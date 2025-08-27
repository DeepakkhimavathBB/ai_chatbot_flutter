import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';
import '../models/task.dart';

class DBService {
  static const String userBoxName = "usersBox";
  static const String chatBoxName = "chatsBox";
  static const String taskBoxName = "tasksBox";

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Task Adapter if not registered
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }

    // Open all boxes
    await Hive.openBox(userBoxName);
    await Hive.openBox(chatBoxName);
    await Hive.openBox<Task>(taskBoxName);
  }

  // Users
  static Future<void> insertUser(User user) async {
    var box = Hive.box(userBoxName);
    await box.put(user.email, user.toMap());
  }

  static Future<User?> getUser(String email, String password) async {
    var box = Hive.box(userBoxName);
    if (box.containsKey(email)) {
      var map = Map<String, dynamic>.from(box.get(email));
      if (map['password'] == password) return User.fromMap(map);
    }
    return null;
  }

  // Chats
  static Future<void> insertChat(String userEmail, String message, String response) async {
    var box = Hive.box(chatBoxName);
    List chats = box.get(userEmail, defaultValue: []) as List;
    chats.add({
      'message': message,
      'response': response,
      'timestamp': DateTime.now().toIso8601String()
    });
    await box.put(userEmail, chats);
  }

  static Future<List<Map<String, dynamic>>> getChats(String userEmail) async {
    var box = Hive.box(chatBoxName);
    List chats = box.get(userEmail, defaultValue: []) as List;
    return List<Map<String, dynamic>>.from(chats);
  }
}
