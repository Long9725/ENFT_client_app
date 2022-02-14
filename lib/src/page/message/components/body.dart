import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/ChatMessage.dart';
import 'package:blue/src/page/message/components/chat_input_field.dart';
import 'package:blue/src/page/message/components/message.dart';

class MessageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index])),
        )),
        ChatInputField()
      ],
    );
  }
}


