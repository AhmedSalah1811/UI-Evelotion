import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ui_evelotion/home_page.dart';
import 'package:ui_evelotion/sign_in.dart';
import 'package:ui_evelotion/subscription_page.dart';
import 'package:ui_evelotion/text_field.dart';

import 'about_page.dart';
import 'buildNavButton.dart';
import 'contact.dart';

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

  // دالة تسجيل الدخول عبر API
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

      if (response.statusCode == 200) {
        // نجاح تسجيل الدخول، الانتقال للصفحة الرئيسية
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_page()),
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
      login(); // استدعاء دالة تسجيل الدخول
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

              // Email Field
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

              // Password Field
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

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: validateAndLogin,
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
              SizedBox(height: 70),
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
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavButton(context, "assets/images/home.png", Home_page(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/about.png", About_page(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/subscrption.png",
                  Subscription_page(), widget.runtimeType),
              buildNavButton(context, "assets/images/contact.png", Contact(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/login.png", LoginPage(),
                  widget.runtimeType),
            ],
          ),
        ),
      ),
    );
  }
}
