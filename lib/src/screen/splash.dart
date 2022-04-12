import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:blue/src/page/home.dart';
import 'package:blue/src/provider/user.dart';
import 'package:blue/src/provider/sqflite.dart';
import 'package:blue/src/page/getting_started/getting_started.dart';

import '../model/User.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  bool expanded = false;
  bool opacity = false;
  bool isLogin = false;
  final double _bigFontSize = 178;
  final transitionDuration = const Duration(seconds: 1);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    fetchLogin();

    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        .then((value) => Future.delayed(const Duration(seconds: 1)))
        .then((value) => setState(() => opacity = true))
        .then((value) => Future.delayed(const Duration(seconds: 5)))
        .then((value) {
      if (isLogin != true) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => GettingStartedPage()),
            (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage(title: "")),
            (route) => false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _lottieAnimation.dispose();
    super.dispose();
  }

  @override
  void fetchLogin() async {
    await context.read<SqfliteProvider>().init().then((value) async {
      final user = await context.read<SqfliteProvider>().getData('user');
      await context.read<UserProvider>().fetchUser(user);
      isLogin = context.read<UserProvider>().login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.end,
                      runAlignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AnimatedContainer(
                                width: !expanded ? _bigFontSize : 90,
                                // height: !expanded ? _bigFontSize : 90,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeInOut,
                                child: Image.asset(
                                  "assets/logos/logo_e.png",
                                ),
                              ),
                              AnimatedCrossFade(
                                firstCurve: Curves.fastOutSlowIn,
                                // the same curve as above
                                crossFadeState: !expanded
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 1000),
                                // the same duration as above
                                firstChild: Container(),
                                // an empty container
                                secondChild: Image.asset(
                                  "assets/logos/logo_nft.png",
                                  width: 100,
                                ),
                                // a Row containing rest of our logo
                                alignment: Alignment.centerLeft,
                                // "reveal" the logo from the center left
                                sizeCurve: Curves.easeInOut,
                              ),
                            ]),
                        AnimatedOpacity(
                          opacity: !opacity ? 0 : 1.0,
                          duration: const Duration(milliseconds: 3000),
                          child: Image.asset(
                            "assets/logos/logo_essential_nft.png",
                            width: 156.25,
                          ),
                        )
                      ],
                    ),
                    AnimatedContainer(
                      width: !expanded ? 0 : 22.5,
                      // height: !expanded ? _bigFontSize : 90,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    ),
                  ],
                )
              ],
            )));
  }
}
