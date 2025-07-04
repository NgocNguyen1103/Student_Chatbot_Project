import 'package:student_chatbot/models/chat_message.dart';
class ChatSession {
  final int id;
  final String title;
  final int userId;
  final DateTime createdAt;
  final DateTime lastMessage;

  ChatSession({
    required this.id,
    required this.title,
    required this.userId,
    required this.createdAt,
    required this.lastMessage,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'],
      title: json['title'] ?? 'Untitled',
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      lastMessage: DateTime.parse(json['last_message']),
    );
  }
}
