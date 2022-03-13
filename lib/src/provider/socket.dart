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
    socket = IO.io(
        dotenv.env['SERVER_ADDRESS'],
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableForceNewConnection()
            .disableAutoConnect()
            .build() // disable auto-connection
        );

    // connect event
    socket.onConnect((_) => print('connect'));
    socket.onDisconnect((_) {
      print('disconnect');
    });

    // message event
    socket.on('message', (data) {
      print(data);
      receiveMessage(data);
    });
    socket.on('image', (data) => print(data));
  }

  sendMessage(String message) {
    socket.emit("message", {
      {
        "id": socket.id,
        "message": message,
        "username": "장성호",
        "sendAt": DateTime.now().toLocal().toString()
      }
    });
    messages.add(ChatMessage(
        text: message,
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        time: DateFormat.yMd().add_jm().format(DateTime.now()),
        isSender: true));
    notifyListeners();
  }

  sendImage() {

  }

  receiveMessage(var message) {
    messages.add(ChatMessage(
        text: message['message'],
        messageType: ChatMessageType.text,
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
