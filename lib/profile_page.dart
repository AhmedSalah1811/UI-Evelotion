import 'package:flutter/material.dart';
import 'package:ui_evelotion/text_field.dart';

class Profile_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 45,
              ),
              color: Colors.grey,
              child: Image.asset(
                'assets/images/profile.png',
                height: 80,
                width: 80,
              ),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(color: Colors.grey),
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
    );
  }
}
