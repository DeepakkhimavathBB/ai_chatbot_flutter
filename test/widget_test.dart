// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_chatbot/main.dart';

void main() {
  testWidgets('Basic widget test', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(AIChatApp());

    // Check if RegisterScreen is displayed
    expect(find.text('AI ChatBot'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);

    // Enter text in Name field
    await tester.enterText(find.byType(TextFormField).at(0), 'Test User');
    await tester.enterText(find.byType(TextFormField).at(1), 'test@email.com');
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');

    // Tap Register button
    await tester.tap(find.text('Register'));
    await tester.pump();

    // After registration, LoginScreen should appear
    expect(find.text('Login'), findsOneWidget);
  });
}
