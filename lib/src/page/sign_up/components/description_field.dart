import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key, required this.isVerification})
      : super(key: key);

  final bool isVerification;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: SizedBox(
          height: isVerification ? 0 : 178,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Center(
                  child: Text(
                "휴대폰 번호 인증",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              Text(
                "안녕하세요!\n휴대폰 번호로 로그인해주세요.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text("휴대폰 번호는 안전하게 보관되며 공개되지 않습니다."),
              SizedBox(
                height: kDefaultPadding,
              ),
            ],
          ),
        ));
  }
}
