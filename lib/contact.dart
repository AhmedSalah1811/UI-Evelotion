import 'package:flutter/material.dart';
import 'package:ui_evelotion/text_field.dart';
import 'Login_page.dart';
import 'about_page.dart';
import 'buildNavButton.dart';
import 'home_page.dart';
import 'subscription_page.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Get in Touch',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Have a question? We would love to hear from you.\nSend us a message and we will respond soon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text_Field(hintText: 'Enter your name'),
              SizedBox(height: 20),
              Text(
                "Phone",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text_Field(hintText: 'Enter your phone number'),
              SizedBox(height: 20),
              Text(
                "Message",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                height: 120,
                child: Text_Field(hintText: 'Enter your message'),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Send",
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
