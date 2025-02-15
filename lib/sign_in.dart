import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_evelotion/Login_page.dart';
import 'dart:convert';
import 'package:ui_evelotion/home_page.dart';
import 'package:ui_evelotion/text_field.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  // إضافة حقول للتحكم في النصوص
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool nameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  bool isLoading = false;

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        "https://ui-evolution.onrender.com/auth/signUp"); // رابط API التسجيل

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"}, // تحديد نوع البيانات JSON
      body: jsonEncode({
        "name":
            nameController.text.trim(), // إزالة الفراغات من البداية والنهاية
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "confirmPassword": confirmPasswordController.text.trim(),
      }),
    );

    setState(() {
      isLoading = false; // إيقاف التحميل بعد استلام الاستجابة
    });

    if (response.statusCode == 200) {
      // نجاح عملية التسجيل
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful!")),
      );

      // الانتقال إلى الصفحة الرئيسية بعد نجاح التسجيل
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // فشل التسجيل، إظهار رسالة الخطأ القادمة من الـ API
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String errorMessage = responseData["message"] ?? "Registration failed!";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  void validateAndSubmit() {
    setState(() {
      nameError = nameController.text.isEmpty;
      emailError = emailController.text.isEmpty;
      passwordError = passwordController.text.isEmpty;
      confirmPasswordError = confirmPasswordController.text.isEmpty ||
          confirmPasswordController.text != passwordController.text;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!nameError && !emailError && !passwordError && !confirmPasswordError) {
      registerUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                  hintText: 'Name',
                  controller: nameController,
                  borderColor: nameError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                Text_Field(
                  hintText: 'Email',
                  controller: emailController,
                  borderColor: emailError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                Text_Field(
                  hintText: 'Password',
                  isPassword: true,
                  controller: passwordController,
                  borderColor: passwordError ? Colors.red : null,
                ),
                SizedBox(height: 15),

                Text_Field(
                  hintText: 'Confirm Password',
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

                // زر التسجيل
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : validateAndSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Sign Up",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
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
