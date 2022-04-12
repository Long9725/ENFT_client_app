import 'package:blue/src/page/register/components/rounded_drop_down.dart';
import 'package:blue/src/page/register_profile/register_profile.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/register/components/rounded_button.dart';
import 'package:blue/src/page/register/components/rounded_input_field.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/provider/user.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);

  String name = "";
  String nickname = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/register.json"),
                // RoundedInputField(
                //   hintText: "이름을 입력하세요",
                //   onChanged: (value) {
                //     name = value;
                //   },
                //   onSubmitted: (value) {
                //     context.read<UserProvider>().registerJson['name'] = value;
                //     print(context.read<UserProvider>().registerJson['name']);
                //   },
                // ),
                RoundedInputField(
                  hintText: "닉네임을 입력하세요",
                  onChanged: (value) {
                    nickname = value;
                    print(nickname);
                  },
                  onSubmitted: (value) {
                    context.read<UserProvider>().registerJson['nickname'] =
                        value;
                    print(
                        context.read<UserProvider>().registerJson['nickname']);
                  },
                ),
                RoundedDropDown(values: ['남자', '여자']),
                RoundedButton(
                  onPressed: () {
                    if (nickname == "" || context.read<UserProvider>().registerJson['sex'] == "") return;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => RegisterProfilePage()));
                  },
                  text: '회원가입',
                ),
              ],
            )));
  }
}
