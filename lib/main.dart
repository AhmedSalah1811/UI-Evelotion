import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home_page.dart';
import 'homepage_after_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  final bool isLoggedIn =
      await checkLoginStatus(); // Check if user is logged in
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

// Function to check login status
Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('user_token');
  return token != null; // Return true if token exists
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? Home_page_after_login() // استخدام الخلفية الثلاثية الأبعاد بعد تسجيل الدخول
          : Home_page(), // الشاشة القديمة قبل تسجيل الدخول
    );
  }
}
