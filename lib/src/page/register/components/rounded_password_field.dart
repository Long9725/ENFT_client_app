import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/register/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({Key? key, required this.onChanged})
      : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      onChanged: onChanged,
      decoration: const InputDecoration(
          hintText: "비밀번호",
          icon: Icon(Icons.lock, color: kPrimaryColor),
          suffixIcon: Icon(Icons.visibility, color: kPrimaryColor),
          border: InputBorder.none),
    ));
  }
}
