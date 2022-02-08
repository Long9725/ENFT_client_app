import 'package:blue/src/helper.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SignUpWithPhoneNumberPage extends StatefulWidget {
  const SignUpWithPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<SignUpWithPhoneNumberPage> createState() =>
      SignUpWithPhoneNumberPageState();
}

class SignUpWithPhoneNumberPageState extends State<SignUpWithPhoneNumberPage>
    with TickerProviderStateMixin {
  late AnimationController _animatedController;
  final _phoneNumberEditingController = TextEditingController();
  final _verificationEditingController = TextEditingController();
  bool _isMessageAvailable = false;
  bool _isVerificationAvailable = false;
  bool _isVerification = false;

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animatedController.dispose();
    _phoneNumberEditingController.dispose();
    _verificationEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildDescriptionBox(),
                        buildMessageBox(),
                        buildVerificationBox()
                      ],
                    )))));
  }

  Widget buildDescriptionBox() {
    return AnimatedSize(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: SizedBox(
          height: _isVerification ? 0 : 174,
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

  Widget buildMessageBox() {
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
                      ? () {
                    setState(() {
                      _isVerification = true;
                    });
                  }
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

  Widget buildVerificationBox() {
    return AnimatedSize(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: SizedBox(
            height: _isVerification ? 183 : 0,
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
                  controller: _verificationEditingController,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        _isVerificationAvailable = true;
                      });
                    } else {
                      setState(() {
                        _isVerificationAvailable = false;
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
                    opacity: _isVerificationAvailable ? 1.0 : 0.5,
                    child: SizedBox(
                        height: 44,
                        child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  const Color(0xFFF0F0F0)),
                              backgroundColor: MaterialStateProperty.all(
                                  _isVerificationAvailable
                                      ? kPrimaryColor
                                      : Colors.grey[500]),
                            ),
                            onPressed: _isVerificationAvailable
                                ? () {
                              setState(() {
                                _isVerification = false;
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