import 'package:flutter/material.dart';

import './screen/splash.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
