import 'package:blue/src/provider/user.dart';
import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

import 'package:blue/src/page/getting_started/components/klip_login_button.dart';
import 'package:blue/src/page/getting_started/components/started_page_view.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/page/register/register.dart';

class GettingStartedBody extends StatelessWidget {
  const GettingStartedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double belowSlideDotsHeight = 94.0; // 88+6
    double pageViewHeight = 304.0; // 200 + 16*2 + 24 + 16 + 16*2
    double paddingSlideDotsFromBtn = (height -
            (belowSlideDotsHeight + pageViewHeight + kDefaultPadding * 2)) /
        4;

    return SafeArea(
        child: Stack(children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: <Widget>[
            Expanded(child: StartedPageView()),
            SizedBox(height: paddingSlideDotsFromBtn),
            KlipLoginButton(onPressed: () {
              context.read<UserProvider>().registerJson['address'] =
                  "0xb438de8ac7be89f5f65dcd9d17a5029ee050edf7";
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterPage()));
            }),
          ],
        ),
      )
    ]));
  }
}
