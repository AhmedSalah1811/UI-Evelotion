import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ui_evelotion/homepage_after_login.dart';
import 'package:ui_evelotion/sign_in.dart';
import 'package:ui_evelotion/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? loginError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // دالة تسجيل الدخول عبر API وتخزين التوكن
  Future<void> login() async {
    final String url = 'https://ui-evolution.onrender.com/auth/logIn';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);
      final String? token = responseData['token'];

      if (response.statusCode == 200 && token != null) {
        // حفظ التوكن في SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);

        // توجيه المستخدم إلى صفحة AboutPage بعد النجاح
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_page_after_login()),
        );
      } else {
        setState(() {
          loginError = responseData['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        loginError = 'An error occurred. Please try again later.';
      });
    }
  }

  void validateAndLogin() {
    setState(() {
      emailError = emailController.text.isEmpty ? "Email is required" : null;
      passwordError =
          passwordController.text.isEmpty ? "Password is required" : null;
      loginError = null;
    });

    if (emailError == null && passwordError == null) {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 1),
              Image.asset(
                'assets/images/logo.png',
                height: 250,
                width: double.infinity,
              ),
              SizedBox(height: 20),
              Text_Field(
                hintText: 'Enter your email',
                controller: emailController,
              ),
              if (emailError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    emailError!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(height: 20),
              Text_Field(
                hintText: 'Enter your password',
                controller: passwordController,
                isPassword: true,
              ),
              if (passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    passwordError!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              if (loginError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    loginError!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: validateAndLogin, // التحقق وتسجيل الدخول
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "First time?",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
