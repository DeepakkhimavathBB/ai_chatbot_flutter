// lib/services/ai_service.dart
class AIService {
  // Predefined questions & answers
  static Map<String, String> predefinedQA = {
    "hello": "Hello! How are you today?",
    "your name": "I'm your AI friend!",
    "how are you": "I'm doing great! How about you?",
    "time": "I can't see real time yet, but soon!",
    "math": "2 + 2 = 4 😊",
    "who created you": "Deepak created me! 😎",
    "joke": "Why did the computer go to the doctor? Because it caught a virus! 😂",
    "motivation": "Keep pushing forward! Every step counts!",
    "quote": "Believe in yourself! Every day is a new chance."
  };

  // Get response based on keyword matching
  static String getResponse(String message) {
    message = message.toLowerCase();

    for (var key in predefinedQA.keys) {
      if (message.contains(key)) {
        return predefinedQA[key]!;
      }
    }

    return "Sorry, I don't know that yet, but I'm learning!";
  }
}
