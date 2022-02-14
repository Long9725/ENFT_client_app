import 'package:blue/src/page/sign_up/components/sms_code_input_field.dart';
import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

import 'package:blue/src/page/sign_up/components/description_field.dart';
import 'package:blue/src/page/sign_up/components/phone_number_input_field.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  bool _isVerification = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DescriptionField(isVerification: _isVerification),
                    PhoneNumberInputField(
                      onPressed: () {
                        setState(() {
                          _isVerification = true;
                        });
                      },
                    ),
                    SMSCodeInputField(isVerification: _isVerification)
                  ],
                ))));
  }
}
