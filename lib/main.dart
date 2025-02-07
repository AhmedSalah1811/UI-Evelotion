import 'package:flutter/material.dart';
import 'package:ui_evelotion/about_page.dart';
import 'package:ui_evelotion/home_page.dart';
import 'package:ui_evelotion/output_page.dart';
import 'package:ui_evelotion/sign_in.dart';
import 'package:ui_evelotion/subscription_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_page(), //
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Login(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Home_page(),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About this page',
      home: About_page(),
    );
  }
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'profile',
      home: Contact(),
    );
  }
}

class subscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'subscription',
      home: Subscription_page(),
    );
  }
}

class output extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'output',
      home: OutputPage(),
    );
  }
}

class Signpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign in',
      home: Signin(),
    );
  }
}
