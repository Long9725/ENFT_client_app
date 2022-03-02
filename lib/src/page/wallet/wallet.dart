import 'package:flutter/material.dart';

import 'package:blue/src/page/wallet/components/body.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body()
    );
  }
}