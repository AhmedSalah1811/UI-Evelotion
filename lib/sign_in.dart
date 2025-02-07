import 'package:flutter/material.dart';
import 'package:ui_evelotion/home_page.dart';
import 'package:ui_evelotion/text_field.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool firstNameError = false;
  bool lastNameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;

  void validateAndSubmit() {
    setState(() {
      firstNameError = firstNameController.text.isEmpty;
      lastNameError = lastNameController.text.isEmpty;
      emailError = emailController.text.isEmpty;
      passwordError = passwordController.text.isEmpty;
      confirmPasswordError = confirmPasswordController.text.isEmpty ||
          confirmPasswordController.text != passwordController.text;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!firstNameError &&
        !lastNameError &&
        !emailError &&
        !passwordError &&
        !confirmPasswordError) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home_page()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: double.infinity,
                ),
                SizedBox(height: 20),

                Text_Field(
                  hintText: 'First name',
                  controller: firstNameController,
                  borderColor: firstNameError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                Text_Field(
                  hintText: 'Last name',
                  controller: lastNameController,
                  borderColor: lastNameError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                // Email Field
                Text_Field(
                  hintText: 'Enter your email',
                  controller: emailController,
                  borderColor: emailError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                Text_Field(
                  hintText: 'Enter your password',
                  isPassword: true,
                  controller: passwordController,
                  borderColor: passwordError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                Text_Field(
                  hintText: 'Confirm your password',
                  isPassword: true,
                  controller: confirmPasswordController,
                  borderColor: confirmPasswordError ? Colors.red : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
