import 'package:blue/src/provider/socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/ChatMessage.dart';
import 'package:blue/src/page/message/components/chat_input_field.dart';
import 'package:blue/src/page/message/components/message.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({Key? key}) : super(key: key);

  @override
  State<MessageBody> createState() => MessageBodyState();
}

class MessageBodyState extends State<MessageBody> {
  @override
  void initState() {
    super.initState();
    context.read<SocketProvider>().socket.connect();
  }

  @override
  void deactivate() {
    context.read<SocketProvider>().socket.disconnect();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
              itemCount: context.watch<SocketProvider>().messages.length,
              itemBuilder: (context, index) =>
                  Message(message: context.watch<SocketProvider>().messages[index])),
        )),
        ChatInputField()
      ],
    );
  }
}
