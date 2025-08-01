import 'package:flutter/material.dart';
import 'package:student_chatbot/pages/home_page.dart';
import 'package:student_chatbot/pages/signup_page.dart';
import 'package:student_chatbot/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _error = false;

  void _login() async {
    setState(() {
      _loading = true;
      _error = false;
    });
    final token = await AuthService().login(_email.text, _password.text);
    setState(() {
      _loading = false;
    });
    if (token != null) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {"method": "email", "token": token}
      );
    }else{
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/white_try_logo.png",
                  width: 300,
                  height: 300,
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Text(
                    "StudentChat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),

                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      // viền khi không focus
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // viền khi focus
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black, width: 3.0),
                    ),
                    hintText: "Username",
                  ),
                  onEditingComplete: () => setState(() {}),
                ),

                SizedBox(height: 15),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      // viền khi không focus
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // viền khi focus
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black, width: 3.0),
                    ),
                    hintText: "Password",
                  ),
                  onEditingComplete: () => setState(() {}),
                ),

                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Forgot Password? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Click here",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),
                FilledButton(
                  onPressed: _login,

                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Login", style: TextStyle(fontSize: 16)),
                ),

                SizedBox(height: 25),
                Row(
                  children: [
                    // Line bên trái
                    Expanded(
                      child: Divider(
                        thickness: 1, // độ dày line
                        color: Colors.grey[400], // màu line
                      ),
                    ),

                    // Text ở giữa với padding ngang
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Line bên phải
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[400]),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupPage();
                        },
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),

                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Create Account", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}