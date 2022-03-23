import 'dart:io';

import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/ChatMessage.dart';
import 'package:blue/src/page/message/components/audio_message.dart';
import 'package:blue/src/page/message/components/text_message.dart';
import 'package:blue/src/page/message/components/image_message.dart';
import 'package:blue/src/page/message/components/video_message.dart';
import 'package:blue/src/page/message/components/message_status_dot.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContain(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.image:
          return ImageMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
          break;
        case ChatMessageType.video:
          return VideoMessage(message: message);
          break;
        default:
          return SizedBox();
      }
    }

    return Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding),
        child: Row(
          mainAxisAlignment: message.isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!message.isSender) ...[
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage("assets/photos/basic-profile.jpg"),
              ),
              SizedBox(
                width: kDefaultPadding / 2,
              )
            ],
            if(message.isSender) ...[
              Text(message.time.substring(13)),
              SizedBox(
                width: kDefaultPadding / 2,
              )
            ],
            messageContain(message),
            if (message.isSender)
              MessageStatusDot(status: message.messageStatus),
            if (!message.isSender) ...[
              SizedBox(
                width: kDefaultPadding / 2,
              ),
              Text(message.time.substring(13)),
            ]
          ],
        ));
  }
}
