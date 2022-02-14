import 'package:flutter/material.dart';

enum ChatMessgaeType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessgaeType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.isSender
  });
}

List demeChatMessages = [
  ChatMessage(text: "안녕하세요", messageType: ChatMessgaeType.text, messageStatus: MessageStatus.viewed, isSender: false),
  ChatMessage(text: "", messageType: ChatMessgaeType.audio, messageStatus: MessageStatus.viewed, isSender: false),
  ChatMessage(text: "", messageType: ChatMessgaeType.video, messageStatus: MessageStatus.viewed, isSender: true),
  ChatMessage(text: "문제가 발생했습니다", messageType: ChatMessgaeType.text, messageStatus: MessageStatus.not_sent, isSender: true),
  ChatMessage(text: "잘 지내세요?", messageType: ChatMessgaeType.text, messageStatus: MessageStatus.viewed, isSender: false),
  ChatMessage(text: "네", messageType: ChatMessgaeType.text, messageStatus: MessageStatus.viewed, isSender: true),
];