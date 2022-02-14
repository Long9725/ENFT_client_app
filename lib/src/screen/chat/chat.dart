import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/Chat.dart';
import 'package:blue/src/screen/chat/components/body.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("채팅"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: ChatBody());
  }
}
