import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

class LoginField extends StatelessWidget {
  final Function() press;

  const LoginField({Key? key, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 40,
          child: OutlinedButton(
            child: const Text(
              "시작하기",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: press,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              foregroundColor:
                  MaterialStateProperty.all(const Color(0xFFF0F0F0)),
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "이미 계정이 있나요?",
              style: TextStyle(color: Colors.black54),
            ),
            TextButton(
                onPressed: press,
                child: const Text(
                  "로그인",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        )
      ],
    );
  }
}
