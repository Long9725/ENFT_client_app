import 'package:blue/src/model/ChatMessage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider with ChangeNotifier {
  late final IO.Socket socket;
  List messages = [];

  SocketProvider() {
    initSocket();
  }

  void initSocket() {
    socket = IO.io(dotenv.env['SERVER_ADDRESS'],IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()
        .build()  // disable auto-connection
    );
    socket.connect();
    socket.onConnect((_) => print('connect'));
    socket.on('event', (data) => print(data));
    socket.on('fromServer', (_) => print(_));
    socket.onDisconnect((_) => print('disconnect'));
  }

  sendMessage(String message) {
    socket.emit("msg", {
      {
        "id": socket.id,
        "message": message,
        "username": "장성호",
        "sendAt": DateTime.now().toLocal().toString()
      }
    });
    messages.add(ChatMessage(text: message, messageType: ChatMessageType.text, messageStatus: MessageStatus.viewed, isSender: true) );
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
