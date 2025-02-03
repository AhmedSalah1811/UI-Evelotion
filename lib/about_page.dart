import 'package:flutter/material.dart';

class About_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 30),
              color: Colors.orange,
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
              decoration: BoxDecoration(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'About Application',
                style: TextStyle(fontSize: 25, color: Colors.orange),
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
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                ),
                Expanded(
                  child: Text(
                      'simple website that allows users to design user interfaces for apps using artificial intelligence. ',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
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
                        style: TextStyle(fontSize: 20, color: Colors.red))),
                Expanded(
                  child: Text(
                      'input text with the details they want for the interface, and the system converts it into a ready-made design. ',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
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
                        style: TextStyle(fontSize: 20, color: Colors.red))),
                Expanded(
                  child: Text(
                      'help users to design interfaces that reflect the local visual identity using "Generative AI',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
