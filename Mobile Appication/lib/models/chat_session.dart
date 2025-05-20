import 'package:student_chatbot/models/chat_message.dart';

class ChatSession{
  final String id;
  final List<ChatMessage> messages;
  ChatSession({required this.id, required this.messages});

}