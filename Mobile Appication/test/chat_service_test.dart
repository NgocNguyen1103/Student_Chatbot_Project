// test/chat_service_test.dart

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:student_chatbot/services/chat_services.dart';
import 'package:student_chatbot/models/chat_session.dart';
import 'package:student_chatbot/models/chat_message.dart';

void main() {
  late ChatService service;

  group('ChatService.getSessions', () {
    test('trả về list ChatSession khi statusCode == 200', () async {
      final mockResponse = jsonEncode([
        {
          'id': 1,
          'title': 'Session 1',
          'user_id': 10,
          'created_at': '2025-07-20T10:00:00Z',
          'last_message': '2025-07-20T10:05:00Z',
        },
        {
          'id': 2,
          'title': 'Session 2',
          'user_id': 20,
          'created_at': '2025-07-21T11:00:00Z',
          'last_message': '2025-07-21T11:05:00Z',
        },
      ]);

      final client = MockClient((request) async {
        // Kiểm tra method và endpoint
        expect(request.method, 'GET');
        expect(request.url.path, '/chat/get_chat_sessions');
        // Kiểm tra header Authorization
        expect(request.headers['Authorization'], 'Bearer token123');
        return http.Response(mockResponse, 200);
      });

      service = ChatService(client: client);
      final sessions = await service.getSessions('token123');

      expect(sessions, isA<List<ChatSession>>());
      expect(sessions.length, 2);
      expect(sessions[0].id, 1);
      expect(sessions[0].title, 'Session 1');
      expect(sessions[1].userId, 20);
    });

    test('ném Exception khi statusCode != 200', () async {
      final client = MockClient((_) async => http.Response('', 500));
      service = ChatService(client: client);

      expect(
        () => service.getSessions('token123'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to load sessions'),
          ),
        ),
      );
    });
  });

  group('ChatService.getMessages', () {
    test('trả về list ChatMessage khi statusCode == 200', () async {
      final mockResponse = jsonEncode([
        {
          'id': 10,
          'chat_session_id': 1,
          'sender': 'A',
          'sequence_no': 1,
          'content': 'Hello',
          'created_at': '2025-07-22T12:00:00Z',
        },
        {
          'id': 11,
          'chat_session_id': 1,
          'sender': 'B',
          'sequence_no': 2,
          'content': 'Hi',
          'created_at': '2025-07-22T12:01:00Z',
        },
      ]);

      final client = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/chat/get_old_messages/1');
        expect(request.headers['Authorization'], 'Bearer tok');
        return http.Response(mockResponse, 200);
      });

      service = ChatService(client: client);
      final messages = await service.getMessages(1, 'tok');

      expect(messages, isA<List<ChatMessage>>());
      expect(messages.length, 2);
      expect(messages[0].id, 10);
      expect(messages[0].sequenceNo, 1);
      expect(messages[1].content, 'Hi');
    });

    test('ném Exception khi statusCode != 200', () async {
      final client = MockClient((_) async => http.Response('oops', 404));
      service = ChatService(client: client);

      expect(
        () => service.getMessages(1, 'tok'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to load messages'),
          ),
        ),
      );
    });
  });

  group('ChatService.startChat', () {
    test('trả về Map khi statusCode == 200', () async {
      final mockMap = {
        'session_id': 99,
        'title': 'New Chat',
        'user_id': 5,
        'created_at': '2025-07-22T00:00:00Z',
        'last_message': '2025-07-22T00:01:00Z',
      };

      final client = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/chat/newchat');
        expect(request.headers['Authorization'], 'Bearer tok');
        final body = jsonDecode(request.body) as Map;
        expect(body['content'], 'Hi there');
        return http.Response(jsonEncode(mockMap), 200);
      });

      service = ChatService(client: client);
      final result = await service.startChat('Hi there', 'tok');

      expect(result, isA<Map<String, dynamic>>());
      expect(result['session_id'], 99);
      expect(result['title'], 'New Chat');
    });

    test('ném Exception khi statusCode != 200', () async {
      final client = MockClient((_) async => http.Response('', 500));
      service = ChatService(client: client);

      expect(
        () => service.startChat('Hey', 'tok'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to create chat session'),
          ),
        ),
      );
    });
  });

  group('ChatService.continueChat', () {
    test('trả về Map khi statusCode == 200', () async {
      final mockMap = {
        'message_id': 123,
        'chat_session_id': 2,
        'sender': 'bot',
        'sequence_no': 2,
        'content': 'Reply',
        'created_at': '2025-07-22T12:05:00Z',
      };

      final client = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/chat/continue');
        expect(request.headers['Authorization'], 'Bearer tok');
        final body = jsonDecode(request.body) as Map;
        expect(body['chat_session_id'], 2);
        expect(body['content'], 'Reply');
        return http.Response(jsonEncode(mockMap), 200);
      });

      service = ChatService(client: client);
      final result = await service.continueChat(2, 'Reply', 'tok');

      expect(result, isA<Map<String, dynamic>>());
      expect(result['message_id'], 123);
      expect(result['content'], 'Reply');
    });

    test('ném Exception khi statusCode != 200', () async {
      final client = MockClient((_) async => http.Response('', 400));
      service = ChatService(client: client);

      expect(
        () => service.continueChat(2, 'OK', 'tok'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to send messsage'),
          ),
        ),
      );
    });
  });
}
