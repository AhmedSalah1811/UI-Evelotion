import 'package:flutter/material.dart';
import 'package:ui_evelotion/output_page.dart';
import 'Login_page.dart';
import 'buildNavButton.dart';
import 'subscription_page.dart';
import 'profile_page.dart';
import 'about_page.dart';

class Home_page extends StatefulWidget {
  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // مفتاح التحقق من صحة الإدخال
  String? errorMessage;

  void navigateToOutputPage(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String inputText = searchController.text.trim();
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 300,
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
                      TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Enter your prompt here",
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.black45,
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          errorText: errorMessage,
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter your prompt";
                          }
                          return null;
                        },
                      ),
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
                          "Generate",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
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
