import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mfu_life_demo/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String apiKey = 'AIzaSyCILBzcv5eXw5jtXLwHIYkaPB7ekk2HvCs';
  final String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<String> generateResponse(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to generate response');
    }
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    _scrollToBottom();

    try {
      final response = await generateResponse(text);
      setState(() {
        _messages.add({'sender': 'bot', 'text': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'error', 'text': e.toString()});
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MFU Chatbot', style: appbarStyle),
        centerTitle: true,
        backgroundColor: const Color(0xFF7A060D),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                final isError = message['sender'] == 'error';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isError
                          ? Colors.redAccent.withOpacity(0.1)
                          : isUser
                              ? Colors.blueAccent.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                        bottomLeft:
                            isUser ? Radius.circular(12.0) : Radius.zero,
                        bottomRight:
                            isUser ? Radius.zero : Radius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isError ? Colors.redAccent : Colors.black87,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: 'Send a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueAccent),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:mfu_life_demo/constants.dart';
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final String apiKey = 'AIzaSyCILBzcv5eXw5jtXLwHIYkaPB7ekk2HvCs';
//   final String baseUrl =
//       'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
//   final TextEditingController _textController = TextEditingController();
//   final List<String> _messages = [];
//
//   Future<String> generateResponse(String prompt) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl?key=$apiKey'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'contents': [
//           {
//             'parts': [
//               {'text': prompt}
//             ]
//           }
//         ]
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);
//       return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
//     } else {
//       throw Exception('Failed to generate response');
//     }
//   }
//
//   void _handleSubmitted(String text) async {
//     _textController.clear();
//     setState(() {
//       _messages.add('You: $text');
//     });
//
//     try {
//       final response = await generateResponse(text);
//       setState(() {
//         _messages.add('Bot: $response');
//       });
//     } catch (e) {
//       setState(() {
//         _messages.add('Error: ${e.toString()}');
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Gemini Chatbot',
//           style: appbarStyle,
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         backgroundColor: const Color(0xFF7A060D),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text(_messages[index]),
//               ),
//             ),
//           ),
//           Divider(height: 1.0),
//           Container(
//             decoration: BoxDecoration(color: Theme.of(context).cardColor),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           children: [
//             Flexible(
//               child: TextField(
//                 controller: _textController,
//                 onSubmitted: _handleSubmitted,
//                 decoration:
//                     InputDecoration.collapsed(hintText: 'Send a message'),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 4.0),
//               child: IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () => _handleSubmitted(_textController.text),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
