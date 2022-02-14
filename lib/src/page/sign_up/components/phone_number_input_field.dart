import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

class PhoneNumberInputField extends StatefulWidget {
  const PhoneNumberInputField({Key? key, required this.onPressed}) : super(key: key);

  final Function() onPressed;

  @override
  State<PhoneNumberInputField> createState() => PhoneNumberInputFieldState();
}

class PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  final _phoneNumberEditingController = TextEditingController();
  bool _isMessageAvailable = false;

  @override
  void dispose() {
    _phoneNumberEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(
        decoration: const InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            hintText: "휴대폰 번호(- 없이 숫자만 입력)",
            counterText: ""),
        controller: _phoneNumberEditingController,
        maxLength: 11,
        keyboardType: TextInputType.number,
        onChanged: (text) {
          if (text.length >= 8) {
            setState(() {
              _isMessageAvailable = true;
            });
          } else {
            setState(() {
              _isMessageAvailable = false;
            });
          }
        },
      ),
      const SizedBox(height: kDefaultPadding),
      Opacity(
          opacity: _isMessageAvailable ? 1.0 : 0.5,
          child: SizedBox(
              height: 44,
              child: OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(const Color(0xFFF0F0F0)),
                    backgroundColor: MaterialStateProperty.all(
                        _isMessageAvailable
                            ? Colors.black87
                            : Colors.grey[500]),
                  ),
                  onPressed: _isMessageAvailable
                      ? widget.onPressed
                      : () {},
                  child: const Text(
                    "인증문자 받기",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )))),
    ]);
  }
}
