import 'package:flutter/material.dart';

import 'package:blue/src/page/register/components/body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: RegisterBody());
  }
}
