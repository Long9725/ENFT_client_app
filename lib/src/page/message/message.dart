import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/message/components/body.dart';

import '../../provider/socket.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  @override
  void deactivate() {
    // if(context.read<SocketProvider>().socket)
    disconnectToSocket();
    super.deactivate();
  }

  connectToSocket() => context.read<SocketProvider>().socket.connect();
  disconnectToSocket() => context.read<SocketProvider>().socket.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: MessageBody());
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/photos/basic-profile.jpg"),
          ),
          SizedBox(
            width: kDefaultPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("장성호", style: TextStyle(fontSize: 18)),
              Text("최근 활동: 5분 전", style: TextStyle(fontSize: 14))
            ],
          )
        ],
      ),
    );
  }
}
