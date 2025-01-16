import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  List<List<dynamic>> _qaData = [];

  @override
  void initState() {
    super.initState();
    _loadQAData();
  }

  Future<void> _loadQAData() async {
    final rawData = await rootBundle.loadString('assets/train_chatbot - Sheet1.csv');
    _qaData = const CsvToListConverter().convert(rawData);
  }

  String _findAnswer(String question) {
    question = question.toLowerCase();

    for (var row in _qaData) {
      if (row.length >= 2) {
        String storedQuestion = row[0].toString().toLowerCase();
        if (storedQuestion.contains(question) ||
            question.contains(storedQuestion)) {
          return row[1].toString();
        }
      }
    }

    return "I'm sorry, I don't have an answer for that question.";
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      String response = _findAnswer(text);
      _messages.add(ChatMessage(text: response, isUser: false));
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RailRelax Chatbot'),
      backgroundColor: Colors.blue),
      body: SafeArea(  // Added SafeArea
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,  // Added reverse scrolling
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];  // Reversed message order
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: message.isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Flexible(  // Added Flexible
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: message.isUser
                                  ? Colors.blue[100]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              message.text,
                              softWrap: true,  // Added softWrap
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(  // Wrapped input area in Container
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, MediaQuery.of(context).viewInsets.bottom + 8),  // Added padding for keyboard
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),  // Adjusted padding
                        ),
                        maxLines: null,  // Allow multiple lines
                        textInputAction: TextInputAction.send,  // Changed to send action
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    SizedBox(width: 8),  // Added spacing
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => _handleSubmitted(_controller.text),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}