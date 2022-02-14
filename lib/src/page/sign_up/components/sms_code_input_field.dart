import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/home.dart';

class SMSCodeInputField extends StatefulWidget {
  const SMSCodeInputField({Key? key, required this.isVerification})
      : super(key: key);

  final bool isVerification;

  @override
  State<SMSCodeInputField> createState() => SMSCodeInputFieldState();
}

class SMSCodeInputFieldState extends State<SMSCodeInputField> {
  final _smsCodeEditingController = TextEditingController();
  bool _isSMSCode = false;

  @override
  void dispose() {
    _smsCodeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: SizedBox(
            height: widget.isVerification ? 187 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: kDefaultPadding * 2),
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "인증번호 입력",
                      counterText: ""),
                  controller: _smsCodeEditingController,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        _isSMSCode = true;
                      });
                    } else {
                      setState(() {
                        _isSMSCode = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(
                  "어떤 경우에도 타인에게 공유하지 마세요!",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Opacity(
                    opacity: _isSMSCode ? 1.0 : 0.5,
                    child: SizedBox(
                        height: 44,
                        child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  const Color(0xFFF0F0F0)),
                              backgroundColor: MaterialStateProperty.all(
                                  _isSMSCode
                                      ? kPrimaryColor
                                      : Colors.grey[500]),
                            ),
                            onPressed: _isSMSCode
                                ? () {
                                    setState(() {
                                      _isSMSCode = false;
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(title: "")));
                                  }
                                : () {},
                            child: const Text(
                              "인증문자 확인",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ))))
              ],
            )));
  }
}
