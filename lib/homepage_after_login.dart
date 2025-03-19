import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_evelotion/home_page.dart';
import 'package:ui_evelotion/output_page.dart';
import 'package:ui_evelotion/profile.dart';

import 'Login_page.dart';
import 'buildNavButton.dart';
import 'contact.dart';
import 'subscription_page.dart';
import 'about_page.dart';

class Home_page_after_login extends StatefulWidget {
  @override
  _Home_page_State createState() => _Home_page_State();
}

class _Home_page_State extends State<Home_page_after_login> {
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  void navigateToOutputPage(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String inputText = searchController.text.trim();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 270,
              width: double.infinity,
              child: Image.asset('assets/images/logo.png'),
            ),
            Container(
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      if (errorMessage != null)
                        Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            navigateToOutputPage(context);
                          } else {
                            setState(() {
                              errorMessage = "";
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(200, 50),
                        ),
                        child: Text(
                          "Start Generate",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 9),
                      SizedBox(height: 70),
                      Center(
                        child: Text('Why Choose UI Evolution?',
                            style:
                                TextStyle(fontSize: 22, color: Colors.black)),
                      ),
                      SizedBox(height: 40),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(), //
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        children: [
                          Features(title: 'Speed', features: [
                            'Generate complete UI in seconds not hours.Steramline your development '
                          ]),
                          Features(title: 'Custmoiztion', features: [
                            'Tailor every aspect of your UI to match your brand and requirements perfectly'
                          ]),
                          Features(title: 'Professional', features: [
                            'Get production-ready code that follows best practcis and modren standers'
                          ]),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
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
              // زر الهوم
              IconButton(
                icon: Image.asset("assets/images/home.png"),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final String? token = prefs.getString('user_token');
                  if (token != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home_page_after_login(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home_page(),
                      ),
                    );
                  }
                },
              ),

              buildNavButton(context, "assets/images/about.png", About_page(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/subscrption.png",
                  Subscription_page(), widget.runtimeType),
              buildNavButton(context, "assets/images/contact.png", Contact(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/profile.png",
                  ProfilePage(), widget.runtimeType),
            ],
          ),
        ),
      ),
    );
  }
}
