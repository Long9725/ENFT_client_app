import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/login/components/already_have_an_account_check.dart';
import 'package:blue/src/page/login/components/rounded_button.dart';
import 'package:blue/src/page/login/components/rounded_input_field.dart';
import 'package:blue/src/page/login/components/rounded_password_field.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/login.json"),
                RoundedInputField(hintText: "이메일을 입력하세요", onChanged: (value) {}),
                RoundedPasswordField(onChanged: (value) {}),
                RoundedButton(
                  onPressed: () {},
                  text: '로그인',
                ),
                AlreadyHaveAnAccountCheck(login: true, onPressed: () {})
              ],
            )));
  }
}
