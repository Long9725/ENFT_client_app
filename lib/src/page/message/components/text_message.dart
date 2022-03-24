import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({Key? key, required this.message}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.66),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        message.text!,
        softWrap: true,
        maxLines: 18,
        style: TextStyle(
            color: message.isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1?.color),
      ),
    );
  }
}
