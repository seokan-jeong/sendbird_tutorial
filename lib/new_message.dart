import 'package:flutter/material.dart';
import 'sendbird.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _controller = TextEditingController();
  String _userMessage = '';

  void _sendMessage() async{
    // send message
    channel.sendUserMessageWithText(_userMessage, onCompleted: (msg, error){
      print("success");
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                  labelText: 'Send a message...'
              ),
              onChanged: (value){
                setState(() {
                  _userMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}

