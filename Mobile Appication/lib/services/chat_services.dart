// chat_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_session.dart';
import '../models/chat_message.dart';

class ChatService {
  final String baseUrl = 'http://10.0.2.2:8000/chat';
  Future<List<ChatSession>> getSessions(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/get_chat_sessions"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );
    print("Status code: ${res.statusCode}");
    print("Response body: ${res.body}");
    if (res.statusCode == 200) {
      final jsonList = json.decode(res.body) as List;
      return jsonList.map((e) => ChatSession.fromJson(e)).toList();
    } else if (res.statusCode == 200 && res.body.contains("sessions")) {
      final jsonMap = json.decode(res.body);
      return []; // empty sessions
    } else {
      throw Exception("Failed to load sessions");
    }
  }

  Future<List<ChatMessage>> getMessages(int sessionId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get_old_messages/$sessionId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List;
      return jsonList.map((e) => ChatMessage.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load messages: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> startChat(String content, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/newchat'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Trả về dữ liệu của session và message
    } else {
      throw Exception('Failed to create chat session');
    }
  }

  Future<Map<String, dynamic>> continueChat(int sessionId, String content, String token) async {
    final response = await http.post(
        Uri.parse('$baseUrl/continue'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'chat_session_id': sessionId,
          'content': content,
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // Trả về dữ liệu của message
    } else {
      throw Exception('Failed to send messsage');
    }
  }
}

//
//
//
// // chat_services.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/chat_session.dart';
// import '../models/chat_message.dart';
//
// class ChatService {
//   // final String baseUrl = 'http://10.0.2.2:8000/chat';
//   final http.Client client;
//   final String baseUrl;
//
//   ChatService({http.Client? client, String? baseUrl})
//       : client = client ?? http.Client(),
//         baseUrl = baseUrl ?? 'http://10.0.2.2:8000/chat';
//
//   Future<List<ChatSession>> getSessions(String token) async {
//     final res = await client.get(
//       Uri.parse("$baseUrl/get_chat_sessions"),
//       headers: {
//         "Authorization": "Bearer $token",
//         "Content-Type": "application/json"
//       },
//     );
//     print("Status code: ${res.statusCode}");
//     print("Response body: ${res.body}");
//     if (res.statusCode == 200) {
//       final jsonList = json.decode(res.body) as List;
//       return jsonList.map((e) => ChatSession.fromJson(e)).toList();
//     } else if (res.statusCode == 200 && res.body.contains("sessions")) {
//       final jsonMap = json.decode(res.body);
//       return []; // empty sessions
//     } else {
//       throw Exception("Failed to load sessions");
//     }
//   }
//
//   Future<List<ChatMessage>> getMessages(int sessionId, String token) async {
//     final response = await client.get(
//       Uri.parse('$baseUrl/get_old_messages/$sessionId'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final jsonList = json.decode(response.body) as List;
//       return jsonList.map((e) => ChatMessage.fromJson(e)).toList();
//     } else {
//       throw Exception("Failed to load messages: ${response.body}");
//     }
//   }
//
//   Future<Map<String, dynamic>> startChat(String content, String token) async {
//     final response = await client.post(
//       Uri.parse('$baseUrl/newchat'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'content': content,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to create chat session');
//     }
//   }
//
//   Future<Map<String, dynamic>> continueChat(int sessionId, String content, String token) async {
//     final response = await client.post(
//         Uri.parse('$baseUrl/continue'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'chat_session_id': sessionId,
//           'content': content,
//         })
//     );
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to send messsage');
//     }
//   }
// }
//
