import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/core/channel/open/open_channel.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/params/group_channel_params.dart';
import 'package:sendbird_sdk/params/user_message_params.dart';
import 'package:sendbird_tutorial/sendbird.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sendbird',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController();

  late User _user;
  late GroupChannel _channel;
  String _userMessage = '';

  @override
  void initState() {
    super.initState();
    _initSendbird();
  }

  @override
  void dispose() {
    sendbird.disconnect();
    super.dispose();
  }

  void _initSendbird() async {
    // sign in
    _user = await sendbird.connect(userId, accessToken: userAccessToken);

    // // create channel
    // final channelParams = GroupChannelParams()
    //   ..userIds = ['334251', 'peter', 'james']
    //   ..operatorUserIds = ['334251'];
    //
    // final channel = await GroupChannel.createChannel(channelParams);


    // enter channel
    _channel = await GroupChannel.getChannel(channelUrl);
  }

  void _sendMessage() async{
    // send message
    _channel.sendUserMessageWithText(_userMessage, onCompleted: (msg, error){
      print("success");
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sendbird'),
      ),
      body: Container(
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
      ),
    );
  }
}
