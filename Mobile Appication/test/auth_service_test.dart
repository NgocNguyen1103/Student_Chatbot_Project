// test/auth_service_test.dart

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:student_chatbot/services/auth_services.dart';

void main() {
  late AuthService service;

  group('AuthService.signup', () {
    test('trả về true khi statusCode == 200', () async {
      // MockClient trả về Response(statusCode:200) cho đường dẫn /signup
      final client = MockClient((request) async {
        if (request.url.path.endsWith('/signup')) {
          return http.Response('', 200);
        }
        return http.Response('', 500);
      });
      service = AuthService(client: client);

      final ok = await service.signup('a@b.com', 'user', 'pass', 'pass');
      expect(ok, isTrue);
    });

    test('trả về false khi statusCode != 200', () async {
      final client = MockClient((_) async => http.Response('', 400));
      service = AuthService(client: client);

      final ok = await service.signup('a@b.com', 'user', 'pass', 'pass');
      expect(ok, isFalse);
    });
  });

  group('AuthService.login', () {
    test('trả về token khi statusCode == 200', () async {
      const tokenJson = '{"access_token":"tok"}';
      final client = MockClient((request) async {
        if (request.url.path.endsWith('/login')) {
          return http.Response(tokenJson, 200);
        }
        return http.Response('', 500);
      });
      service = AuthService(client: client);

      final token = await service.login('a@b.com', 'pass');
      expect(token, 'tok');
    });

    test('trả về null khi statusCode != 200', () async {
      final client = MockClient((request) async {
        if (request.url.path.endsWith('/login')) {
          return http.Response('', 401);
        }
        return http.Response('', 500);
      });
      service = AuthService(client: client);

      final token = await service.login('a@b.com', 'pass');
      expect(token, isNull);
    });
  });

  group('AuthService.getProfile', () {
    test('trả về Map khi statusCode == 200', () async {
      final profileJson = jsonEncode({'user_name': 'u', 'email': 'a@b.com'});
      final client = MockClient((request) async {
        if (request.url.path.endsWith('/me')) {
          return http.Response(profileJson, 200);
        }
        return http.Response('', 500);
      });
      service = AuthService(client: client);

      final prof = await service.getProfile('tok');
      expect(prof, isA<Map<String, dynamic>>());
      expect(prof!['user_name'], 'u');
    });

    test('trả về null khi statusCode != 200', () async {
      final client = MockClient((request) async {
        if (request.url.path.endsWith('/me')) {
          return http.Response('', 404);
        }
        return http.Response('', 500);
      });
      service = AuthService(client: client);

      final prof = await service.getProfile('tok');
      expect(prof, isNull);
    });
  });
}
