import 'package:flutter/material.dart';

class SignUpWithPhoneNumberPage extends StatefulWidget {
  const SignUpWithPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<SignUpWithPhoneNumberPage> createState() =>
      SignUpWithPhoneNumberPageState();
}

class SignUpWithPhoneNumberPageState extends State<SignUpWithPhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "안녕하세요!\n휴대폰 번호로 로그인해주세요.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        )
      ],
    );
  }
}
