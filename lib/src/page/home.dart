import 'package:blue/src/page/wallet/wallet.dart';
import 'package:flutter/material.dart';

import 'package:blue/src/model/User.dart';

import 'package:blue/src/page/ticket/ticket.dart';
import 'package:blue/src/page/chat/chat.dart';
import 'package:blue/src/page/myInfo.dart';
import 'post_list/post_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List _widgetOptions = [
      const TicketPage(),
      WalletPage(),
      const PostListScreen(),
      ChatPage(),
      MyInfoPage(user: userList[0])
    ];

    return Scaffold(
      body: DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF041e42),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black54,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.smartphone_rounded), label: '이용권'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet_rounded), label: '지갑'),
                BottomNavigationBarItem(icon: Icon(Icons.view_list_rounded), label: '게시글'),
                BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: '채팅'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: '내 정보'),
              ],
            ),
            body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'home',
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
