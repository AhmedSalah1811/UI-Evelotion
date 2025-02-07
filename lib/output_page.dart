import 'package:flutter/material.dart';

class OutputPage extends StatefulWidget {
  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  final TextEditingController promptController = TextEditingController();
  String userMessage = '';
  String botMessage = 'Hello, how can I help you today?';
  String imageUrl = '';

  void sendMessage() {
    setState(() {
      if (promptController.text.isNotEmpty) {
        userMessage = promptController.text;
        botMessage =
            'Here is the result based on your input: ${promptController.text}';

        if (userMessage.contains('cat')) {
          imageUrl = 'https://placekitten.com/200/300';
        } else {
          imageUrl = '';
        }

        promptController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("UI Evolution"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                // Bot message
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:
                        Colors.grey[300], // Gray background for bot's message
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    botMessage,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                // User message
                if (userMessage.isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue, // Blue background for user's message
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      userMessage,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                if (imageUrl.isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.network(imageUrl),
                  ),
              ],
            ),
          ),
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
                  onPressed: sendMessage, // Send the message
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
