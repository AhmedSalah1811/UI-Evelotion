import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OutputPage extends StatefulWidget {
  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  final TextEditingController promptController = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;
  String? authToken;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  // تحميل التوكن من SharedPreferences عند بدء تشغيل الصفحة
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken =
          prefs.getString('user_token'); // هنا يتم استرجاع التوكن المخزن
    });
  }

  Future<void> sendMessage() async {
    if (promptController.text.isEmpty || authToken == null) return;

    String userMessage = promptController.text;
    setState(() {
      messages.add({"role": "user", "message": userMessage});
      isLoading = true;
    });

    promptController.clear();

    try {
      var response = await http.post(
        Uri.parse('https://292d-156-210-251-202.ngrok-free.app/home/chat'),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer $authToken", // التوكن يتم إضافته هنا في الهيدر
        },
        body: jsonEncode({"message": userMessage}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          if (data.containsKey('imagePath')) {
            messages.add({"role": "bot", "message": data['imagePath']});
          } else {
            messages.add({"role": "bot", "message": "No image received."});
          }
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
