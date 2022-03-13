import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final String time;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.time,
    required this.isSender
  });
}

List demeChatMessages = [
  ChatMessage(text: "안녕하세요", messageType: ChatMessageType.text, messageStatus: MessageStatus.viewed, time: "오후 12:00", isSender: false),
  ChatMessage(text: "", messageType: ChatMessageType.audio, messageStatus: MessageStatus.viewed, time: "오후 12:00", isSender: false),
  ChatMessage(text: "", messageType: ChatMessageType.video, messageStatus: MessageStatus.viewed, time: "오후 12:00", isSender: true),
  ChatMessage(text: "문제가 발생했습니다", messageType: ChatMessageType.text, messageStatus: MessageStatus.not_sent, time: "오후 12:00",isSender: true),
  ChatMessage(text: "잘 지내세요?", messageType: ChatMessageType.text, messageStatus: MessageStatus.viewed, time: "오후 12:00",isSender: false),
  ChatMessage(text: "네", messageType: ChatMessageType.text, messageStatus: MessageStatus.viewed, time: "오후 12:00",isSender: true),
];