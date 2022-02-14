import 'package:flutter/material.dart';

import 'package:blue/src/page/chat/components/body.dart';

class ChatPage extends StatelessWidget {
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
