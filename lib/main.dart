import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_tutorial/new_message.dart';
import 'package:sendbird_tutorial/sendbird.dart';

import 'messages.dart';

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
    user = await sendbird.connect(userId, accessToken: userAccessToken);

    // // create channel
    // final channelParams = GroupChannelParams()
    //   ..userIds = ['334251', 'peter', 'james']
    //   ..operatorUserIds = ['334251'];
    //
    // final channel = await GroupChannel.createChannel(channelParams);

    // enter channel
    channel = await GroupChannel.getChannel(channelUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sendbird'),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              NewMessage(),
            ],
          ),
        ));
  }
}
