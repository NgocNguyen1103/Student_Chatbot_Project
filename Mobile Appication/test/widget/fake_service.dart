// // test/widget/fake_services.dart
//
// import 'dart:async';
// import 'package:student_chatbot/services/auth_services.dart';
// import 'package:student_chatbot/services/chat_services.dart';
// import 'package:student_chatbot/models/chat_session.dart';
// import 'package:student_chatbot/models/chat_message.dart';
//
// /// FakeAuthService: stub toàn bộ phương thức signup, login, getProfile
// class FakeAuthService extends AuthService {
//   final bool shouldSignUpSucceed;
//   final bool shouldLoginSucceed;
//   final Map<String, dynamic>? fakeProfile;
//
//   FakeAuthService({
//     this.shouldSignUpSucceed = true,
//     this.shouldLoginSucceed = true,
//     this.fakeProfile,
//   }) : super(client: null, baseUrl: '');
//
//   @override
//   Future<bool> signup(String email, String username, String password, String verifyPassword) async {
//     return shouldSignUpSucceed;
//   }
//
//   @override
//   Future<String?> login(String email, String password) async {
//     return shouldLoginSucceed ? 'fake-token-123' : null;
//   }
//
//   @override
//   Future<Map<String, dynamic>?> getProfile(String token) async {
//     return fakeProfile ?? {'user_name': 'FakeUser', 'email': 'fake@user.com'};
//   }
// }
//
// class FakeChatService extends ChatService {
//   /// we’ll drive everything off of one fake session
//   final ChatSession fakeSession;
//
//   FakeChatService({ required this.fakeSession })
//       : super(client: null, baseUrl: '');
//
//   @override
//   Future<List<ChatSession>> getSessions(String token) async {
//     return [fakeSession];
//   }
//
//   @override
//   Future<Map<String, dynamic>> startChat(String content, String token) async {
//     // wrap our fakeSession under the "session" key
//     return {
//       'session': {
//         'id':          fakeSession.id,
//         'title':       fakeSession.title,
//         'user_id':     fakeSession.userId,
//         'created_at':  fakeSession.createdAt.toIso8601String(),
//         'last_message':fakeSession.lastMessage.toIso8601String(),
//       }
//     };
//   }
//
// // you can leave continueChat/getMessages unimplemented if you never call them
// }
// // /// FakeChatService: stub getSessions, getMessages, startChat, continueChat
// // class FakeChatService extends ChatService {
// //   final List<ChatSession> sessions;
// //   final List<ChatMessage> history;
// //   final ChatMessage? reply;
// //
// //   FakeChatService({
// //     this.sessions = const [],
// //     this.history = const [],
// //     this.reply,
// //   }) : super(client: null, baseUrl: '');
// //
// //   @override
// //   Future<List<ChatSession>> getSessions(String token) async {
// //     return sessions;
// //   }
// //
// //   @override
// //   Future<List<ChatMessage>> getMessages(int sessionId, String token) async {
// //     return history;
// //   }
// //
// //   @override
// //   Future<Map<String, dynamic>> startChat(String content, String token) async {
// //     if (reply != null) {
// //       return {
// //         'chat_session_id': reply!.chatSessionId,
// //         'id': reply!.id,
// //         'sender': reply!.sender,
// //         'sequence_no': reply!.sequenceNo,
// //         'content': reply!.content,
// //         'created_at': reply!.createdAt.toIso8601String(),
// //       };
// //     }
// //     return {};
// //   }
// //
// //   @override
// //   Future<Map<String, dynamic>> continueChat(int sessionId, String content, String token) async {
// //     if (reply != null) {
// //       return {
// //         'chat_session_id': sessionId,
// //         'id': reply!.id,
// //         'sender': reply!.sender,
// //         'sequence_no': reply!.sequenceNo,
// //         'content': reply!.content,
// //         'created_at': reply!.createdAt.toIso8601String(),
// //       };
// //     }
// //     return {};
// //   }
// // }
