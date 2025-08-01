// import 'package:student_chatbot/services/chat_services.dart';
// import 'package:student_chatbot/models/chat_session.dart';
//
// class FakeChatService extends ChatService {
//   FakeChatService() : super(); // dùng client và baseUrl mặc định
//
//   @override
//   Future<List<ChatSession>> getSessions(String token) async {
//     // Trả về ngay một list rỗng hoặc test data
//     return <ChatSession>[];
//   }
// }
// test/widget/fake_chat_service.dart

import 'package:student_chatbot/services/chat_services.dart';
import 'package:student_chatbot/models/chat_session.dart';
import 'package:student_chatbot/models/chat_message.dart';

/// FakeChatService cho phép stub lịch sử và replay một message bot
class FakeChatService extends ChatService {
  final List<ChatMessage> history;
  final ChatMessage reply;

  FakeChatService({
    required this.history,
    required this.reply,
  }) : super(); // dùng constructor mặc định

  @override
  Future<List<ChatSession>> getSessions(String token) async {
    // ChatPage không dùng getSessions nếu bạn đã inject sẵn session,
    // nhưng ta vẫn trả về empty list để an toàn
    return <ChatSession>[];
  }

  @override
  Future<List<ChatMessage>> getMessages(int sessionId, String token) async {
    // Trả về ngay danh sách history đã cấu hình
    return history;
  }

  @override
  Future<Map<String, dynamic>> startChat(String content, String token) async {
    // Nếu ChatPage gọi startChat (tạo session mới), trả về structure giống continueChat
    return {
      'chat_session_id': reply.chatSessionId,
      'id': reply.id,
      'sender': reply.sender,
      'sequence_no': reply.sequenceNo,
      'content': reply.content,
      'created_at': reply.createdAt.toIso8601String(),
    };
  }

  @override
  Future<Map<String, dynamic>> continueChat(int sessionId, String content, String token) async {
    // Trả về phản hồi bot dựa trên `reply` đã cấu hình
    return {
      'chat_session_id': sessionId,
      'id': reply.id,
      'sender': reply.sender,
      'sequence_no': reply.sequenceNo,
      'content': reply.content,
      'created_at': reply.createdAt.toIso8601String(),
    };
  }
}

