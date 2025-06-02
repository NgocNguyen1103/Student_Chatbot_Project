import 'package:flutter/material.dart';
import 'package:student_chatbot/pages/home_page.dart';
import 'package:student_chatbot/pages/login_page.dart';
import '../services/auth_services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _verifyPassword = TextEditingController();
  bool _loading = false;
  bool _error = false;

  void _submit() async {
    setState(() {
      _loading = true;
      _error = false;
    });
    final response = await AuthService().signup(
      _email.text,
      _username.text,
      _password.text,
      _verifyPassword.text,
    );
    setState(() {
      _loading = false;
    });
    if (response)
      Navigator.pushReplacementNamed(context, '/login');
    else{
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/white_try_logo.png",
                        width: 200,
                        height: 200,
                      ),

                      Text(
                        "Welcome to StudentChat!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: "Roboto",
                        ),
                      ),

                      Text(
                        "Sign up and get started",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(height: 50),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            // viền khi không focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // viền khi focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          hintText: "Email",
                        ),
                        onEditingComplete: () => setState(() {}),
                      ),

                      SizedBox(height: 15),

                      TextField(
                        controller: _username,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            // viền khi không focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // viền khi focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          hintText: "Username",
                        ),
                        onEditingComplete: () => setState(() {}),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            // viền khi không focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // viền khi focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          hintText: "Password",
                        ),
                        onEditingComplete: () => setState(() {}),
                      ),
                      SizedBox(height: 15),

                      TextField(
                        controller: _verifyPassword,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            // viền khi không focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // viền khi focus
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          hintText: "Verify Password",
                        ),
                        onEditingComplete: () => setState(() {}),
                      ),

                      SizedBox(height: 25),
                      if (_error)
                        Text(
                          'Signup failed',
                          style: TextStyle(color: Colors.red),
                        ),

                      _loading
                          ? CircularProgressIndicator()
                          : Column(
                            children: [
                              FilledButton(
                                onPressed: _submit,
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(fontSize: 16),
                                ),

                                style: FilledButton.styleFrom(
                                  minimumSize: Size(double.infinity, 50),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),

                              ElevatedButton.icon(
                                onPressed: () {
                                  // xử lý login với Google
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: Image.asset(
                                  'assets/images/gg_gen_logo.png',
                                  width: 30,
                                  height: 30,
                                ),
                                label: const Text(
                                  'Continue with Google',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
