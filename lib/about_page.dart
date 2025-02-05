import 'package:flutter/material.dart';

import 'Login_page.dart';
import 'buildNavButton.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'subscription_page.dart';

class About_page extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<About_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 30),
                color: Colors.white,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: 190,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'About Application',
                  style: TextStyle(fontSize: 25, color: Colors.red),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: Text('Our project:',
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                  ),
                  Expanded(
                    child: Text(
                        'simple website that allows users to design user interfaces for apps using artificial intelligence. ',
                        style: TextStyle(fontSize: 20, color: Colors.black87)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text('Users:',
                          style: TextStyle(fontSize: 20, color: Colors.blue))),
                  Expanded(
                    child: Text(
                        'input text with the details they want for the interface, and the system converts it into a ready-made design. ',
                        style: TextStyle(fontSize: 20, color: Colors.black87)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text('The Aim:',
                          style: TextStyle(fontSize: 20, color: Colors.blue))),
                  Expanded(
                    child: Text(
                        'help users to design interfaces that reflect the local visual identity using "Generative AI',
                        style: TextStyle(fontSize: 20, color: Colors.black87)),
                  ),
                ],
              )
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
