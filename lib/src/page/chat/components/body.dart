import 'dart:io';

import 'package:flutter/material.dart';

import 'package:blue/src/model/Chat.dart';
import 'package:blue/src/page/message/message.dart';
import 'package:provider/provider.dart';
import '../../../provider/socket.dart';
import 'chat_card.dart';

class ChatBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chatsData.length,
        itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => SocketProvider(),
                        child: MessagePage())));
              },
            ));
  }
}
