import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:blue/src/model/ChatMessage.dart';

class SocketProvider with ChangeNotifier {
  late final IO.Socket socket;
  List messages = [];

  SocketProvider() {
    initSocket();
    initializeDateFormatting("ko_KR");
    Intl.defaultLocale = "ko_KR";
  }

  void initSocket() {
    // {transports: [websocket], path: /chat/socket.io, forceNew: true, autoConnect: false}
    socket = IO.io(
        (dotenv.env['SERVER_ADDRESS']),
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setPath('/chat/socket.io')// for Flutter or Dart VM
              .enableForceNew()
              .disableAutoConnect()
              .build() // disable auto-connection
          );

    print("heello");
    // connect event
    socket.onConnect((_) {
      print(socket.id);
      socket.emit('join', 'test');
      print('connect');
    });
    socket.onDisconnect((_) {
      socket.emit('leave', 'test');
      print('disconnect');
    });

    // message event
    socket.on('textMessage', (data) {
      print(data);
      receiveTextMessage(data);
    });
    socket.on('imageMessage', (data) {
      print(data);
      receiveImageMessage(data);
    });
  }

  sendTextMessage(String text) {
    socket.emit("textMessage", {
      // {
      //   "id": socket.id,
      //   "username": "장성호",
      //   "text": text,
      //   "sendAt": DateTime.now().toLocal().toString()
      // }
      {
        "roomId": "test",
        "msg": text
      }
    });

    // room)id
    messages.add(ChatMessage(
        text: text,
        images: null,
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        time: DateFormat.yMd().add_jm().format(DateTime.now()),
        isSender: true));
    notifyListeners();
  }

  sendImageMessage(List<String>? images) {
    // room)id
    messages.add(ChatMessage(
        text: null,
        images: images,
        messageType: ChatMessageType.image,
        messageStatus: MessageStatus.viewed,
        time: DateFormat.yMd().add_jm().format(DateTime.now()),
        isSender: true));
    socket.emit("imageMessage", {
      {
        "id": socket.id,
        "username": "장성호",
        "images": images,
        "sendAt": DateTime.now().toLocal().toString()
      }
    });
    notifyListeners();
  }

  receiveTextMessage(var message) {
    print(message);
    // messages.add(ChatMessage(
    //     text: message['text'],
    //     images: null,
    //     messageType: ChatMessageType.text,
    //     messageStatus: MessageStatus.viewed,
    //     time: DateFormat.yMd().add_jm().format(DateTime.now()),
    //     isSender: false));
    // notifyListeners();
  }

  receiveImageMessage(var message) {
    List<String> images = message['images'].cast<String>();
    messages.add(ChatMessage(
        text: null,
        images: images,
        messageType: ChatMessageType.image,
        messageStatus: MessageStatus.viewed,
        time: DateFormat.yMd().add_jm().format(DateTime.now()),
        isSender: false));
    notifyListeners();
  }
}

const List EVENTS = [
  'connect',
  'connect_error',
  'connect_timeout',
  'connecting',
  'disconnect',
  'error',
  'reconnect',
  'reconnect_attempt',
  'reconnect_failed',
  'reconnect_error',
  'reconnecting',
  'ping',
  'pong'
];
