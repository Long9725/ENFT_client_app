import 'package:blue/src/page/home.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:blue/src/provider/user.dart';
import 'package:blue/src/page/register/components/rounded_button.dart';
import 'package:blue/src/page/register_profile/component/profile_button.dart';

class RegisterProfileBody extends StatelessWidget {
  const RegisterProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileButton(),
        SizedBox(
          height: 16,
        ),
        RoundedButton(
            text: "프로필 등록하기",
            onPressed: () async {
              await context.read<UserProvider>().register(context);
              if (context.read<UserProvider>().login == true)
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => HomePage(title: "")));
            })
      ],
    ));
  }
}
