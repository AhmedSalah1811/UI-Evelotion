import 'package:flutter/material.dart';
import 'package:ui_evelotion/output_page.dart';
import 'package:ui_evelotion/sign_in.dart';
import 'Login_page.dart';
import 'subscription_page.dart';
import 'profile_page.dart';
import 'about_page.dart';

class Home_page extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  void navigateToOutputPage(BuildContext context) {
    String inputText = searchController.text.trim();
    if (inputText.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Output_page(resultText: inputText),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: -5,
              children: [
                buildNavButton(context, "About", About_page()),
                buildNavButton(context, "Subscription", Subscription_page()),
                buildNavButton(context, "Profile", Profile_page()),
                buildNavButton(context, "Login", LoginPage()),
                buildNavButton(context, "Sign in", Signin()),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Container(
            color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your prompt here ",
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.black26,
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Output_page(resultText: value),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Output_page(resultText: '')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      "Generate",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildNavButton(BuildContext context, String title, Widget page) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
