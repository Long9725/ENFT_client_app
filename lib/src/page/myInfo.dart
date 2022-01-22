import 'package:flutter/material.dart';

import 'package:blue/src/model/user.dart';

class MyInfoPage extends StatelessWidget {
  final User user;

  const MyInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
                child: Text(
              "내 정보",
              style: TextStyle(color: Colors.black),
            )),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.black))
          ],
        ),
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            leading: MaterialButton(
              onPressed: () {},
              child: ClipOval(
                  child: Image.asset(user.profile, fit: BoxFit.contain, height: 50, width: 50,)),
            ),
            title: Text(user.nickName),
            subtitle: Text(user.location),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black)),
          )
        ],
      )),
    );
  }
}
