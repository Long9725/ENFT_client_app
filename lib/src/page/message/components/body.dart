import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/message/components/chat_input_field.dart';
import 'package:blue/src/page/message/components/message.dart';
import 'package:blue/src/provider/socket.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
              itemCount: context.watch<SocketProvider>().messages.length,
              itemBuilder: (context, index) => Message(
                  message: context.watch<SocketProvider>().messages[index])),
        )),
        ChatInputField()
      ],
    );
  }
}
