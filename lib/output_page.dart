import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OutputPage extends StatefulWidget {
  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  final TextEditingController promptController = TextEditingController();
  List<Map<String, String>> messages = []; // لحفظ المحادثات
  bool isLoading = false;

  Future<void> sendMessage() async {
    if (promptController.text.isEmpty) return;

    String userMessage = promptController.text;
    setState(() {
      messages.add({"role": "user", "message": userMessage});
      isLoading = true;
    });

    promptController.clear();

    try {
      var response = await http.post(
        Uri.parse('https://ui-evolution.onrender.com/home/chat'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": userMessage}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          messages.add(
              {"role": "bot", "message": data['response'] ?? "No response"});
          if (data.containsKey('image')) {
            messages.add({"role": "image", "message": data['image']});
          }
        });
      } else {
        setState(() {
          messages.add(
              {"role": "bot", "message": "Error: Unable to fetch response."});
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
                if (message["role"] == "image") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.network(message["message"]!),
                  );
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: message["role"] == "user"
                        ? Colors.blue
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message["message"]!,
                    style: TextStyle(
                      color: message["role"] == "user"
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16,
                    ),
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
