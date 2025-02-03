import 'package:flutter/material.dart';

class Output_page extends StatelessWidget {
  @override
  final String resultText;
  const Output_page({Key? key, required this.resultText}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/logo.png')),
    );
  }
}
