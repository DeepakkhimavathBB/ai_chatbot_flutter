// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'services/notification_service.dart';
import 'services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive & Boxes
  await DBService.init();

  // Initialize notifications
  await NotificationService.init();

  // Open Hive box for storing theme preference
  await Hive.openBox('settingsBox');

  runApp(AIChatApp());
}

class AIChatApp extends StatefulWidget {
  @override
  State<AIChatApp> createState() => _AIChatAppState();
}

class _AIChatAppState extends State<AIChatApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    var box = Hive.box('settingsBox');
    isDarkMode = box.get('isDarkMode', defaultValue: false);
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      Hive.box('settingsBox').put('isDarkMode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI ChatBot',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: RegisterScreen(
        onToggleTheme: toggleTheme, // Pass toggle function
      ),
      routes: {
        '/login': (_) => LoginScreen(
              onToggleTheme: toggleTheme,
            ),
      },
    );
  }
}
