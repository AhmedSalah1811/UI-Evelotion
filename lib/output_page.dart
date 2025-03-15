import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_evelotion/Login_page.dart';

class OutputPage extends StatefulWidget {
  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  final TextEditingController promptController = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;
  String? authToken;
  String? loginPromptMessage;
  int attemptCount = 0; // عدد المحاولات

  @override
  void initState() {
    super.initState();
    loadTokenAndAttempts();
  }

  Future<void> loadTokenAndAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('user_token');
      attemptCount = prefs.getInt('attempt_count') ?? 0;

      if (authToken == null) {
        attemptCount = 0;
        prefs.setInt('attempt_count', 0);
      }
    });
  }

  // حفظ عدد المحاولات في SharedPreferences
  Future<void> saveAttemptCount() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('attempt_count', attemptCount);
  }

  Future<void> sendMessage() async {
    if (promptController.text.isEmpty) return;

    // التحقق من عدد المحاولات إذا لم يكن مسجل دخول
    if (authToken == null && attemptCount >= 3) {
      setState(() {
        loginPromptMessage = "You have reached 3 prompts.want more,please ";
      });
      return;
    }

    setState(() {
      messages.add({"role": "user", "message": promptController.text});
      isLoading = true;
      loginPromptMessage = null;

      if (authToken == null) {
        attemptCount++; // زيادة المحاولات إذا لم يكن مسجلًا
        saveAttemptCount(); // حفظ العدد في SharedPreferences
      }
    });

    String userMessage = promptController.text;
    promptController.clear();

    try {
      print('the token');
      print(authToken);
      var response;
      if (authToken != null) {
        response = await http.post(
          Uri.parse('https://884d-156-211-17-212.ngrok-free.app/home/chat'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $authToken",
          },
          body: jsonEncode({"message": userMessage}),
        );
      } else {
        print('token is null');
        response = await http.post(
          Uri.parse('https://884d-156-211-17-212.ngrok-free.app/home/chat'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"message": userMessage}),
        );
      }

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          messages.add({
            "role": "bot",
            "message": data['imagePath'] ?? "No image received."
          });
        });
      } else {
        setState(() {
          messages
              .add({"role": "bot", "message": "Error: Unable to fetch image."});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"role": "bot", "message": "Error: ${e.toString()}"});
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("UI Evolution Chat"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          if (loginPromptMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    loginPromptMessage!,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                if (message["role"] == "bot") {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(message["message"]!),
                  );
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message["message"]!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            ),
          ),
          if (isLoading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promptController,
                    decoration: InputDecoration(
                      hintText: "Enter your prompt here...",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
