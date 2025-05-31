import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<bool> signup(String email, String username, String password, String verifyPassword) async {
    final res = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'username': username, 'password': password, 'verify_password': verifyPassword}),
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

  // Future<String?> googleLogin() async {
  //   final gUser = await GoogleSignIn().signIn();
  //   if (gUser == null) return null;
  //   final gAuth = await gUser.authentication;
  //   final idToken = gAuth.idToken;
  //   final res = await http.post(
  //     Uri.parse('$baseUrl/google-login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'token_id': idToken}),
  //   );
  //   if (res.statusCode == 200) return jsonDecode(res.body)['access_token'];
  //   return null;
  // }

  Future<Map<String, dynamic>?> getProfile(String token) async {
    final res = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) return jsonDecode(res.body);
    return null;
  }
}
