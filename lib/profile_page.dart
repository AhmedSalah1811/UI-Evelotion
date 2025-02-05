import 'package:flutter/material.dart';
import 'package:ui_evelotion/text_field.dart';
import 'Login_page.dart';
import 'about_page.dart';
import 'buildNavButton.dart';
import 'home_page.dart';
import 'subscription_page.dart';

class Profile_page extends StatefulWidget {
  @override
  _AboutProfileState createState() => _AboutProfileState();
}

class _AboutProfileState extends State<Profile_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 45,
              ),
              color: Colors.white,
              child: Image.asset(
                'assets/images/profile.png',
                height: 80,
                width: 80,
              ),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(color: Colors.blue),
            ),
            SizedBox(
              height: 20,
            ),
            Text_Field(hintText: 'Enter your name'),
            SizedBox(
              height: 20,
            ),
            Text_Field(hintText: 'Enter your phone number'),
          ],
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
              buildNavButton(context, "assets/images/profile.png",
                  Profile_page(), widget.runtimeType),
              buildNavButton(context, "assets/images/login.png", LoginPage(),
                  widget.runtimeType),
            ],
          ),
        ),
      ),
    );
  }
}
