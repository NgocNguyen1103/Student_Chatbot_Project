import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8000/auth';

  Future<bool> signup(String email, String username, String password, String verifyPassword) async {
    final res = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'user_name': username, 'password': password, 'verify_password': verifyPassword}),
    );
    return res.statusCode == 200;
  }

  Future<String?> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode == 200) return jsonDecode(res.body)['access_token'];
    return null;
  }

  Future<Map<String, dynamic>?> getProfile(String token) async {
    final res = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) return jsonDecode(res.body);
    return null;
  }
}

// Service for testing
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// // import 'package:google_sign_in/google_sign_in.dart';
//
// class AuthService {
//   // final String baseUrl = 'http://10.0.2.2:8000/auth';
//   final http.Client client;
//   final String baseUrl;
//   AuthService({http.Client? client, String? baseUrl})
//       : client = client ?? http.Client(),
//         baseUrl = baseUrl ?? 'http://10.0.2.2:8000/auth';
//   Future<bool> signup(String email, String username, String password, String verifyPassword) async {
//     final res = await client.post(
//       Uri.parse('$baseUrl/signup'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'user_name': username, 'password': password, 'verify_password': verifyPassword}),
//     );
//     return res.statusCode == 200;
//   }
//
//   Future<String?> login(String email, String password) async {
//     final res = await client.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );
//     if (res.statusCode == 200) return jsonDecode(res.body)['access_token'];
//     return null;
//   }
//
//
//   Future<Map<String, dynamic>?> getProfile(String token) async {
//     final res = await client.get(
//       Uri.parse('$baseUrl/me'),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     if (res.statusCode == 200) return jsonDecode(res.body);
//     return null;
//   }
// }
//
