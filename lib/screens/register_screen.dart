import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/user.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme; // Add this

  const RegisterScreen({Key? key, this.onToggleTheme}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme, // Toggle theme
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('AI ChatBot', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (val) => name = val,
                  validator: (val) => val!.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (val) => email = val,
                  validator: (val) => val!.isEmpty ? 'Enter email' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) => val!.isEmpty ? 'Enter password' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DBService.insertUser(User(name: name, email: email, password: password));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(onToggleTheme: widget.onToggleTheme),
                        ),
                      );
                    }
                  },
                  child: Text('Register'),
                ),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(onToggleTheme: widget.onToggleTheme),
                    ),
                  ),
                  child: Text('Already have account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
