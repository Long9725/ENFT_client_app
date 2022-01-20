import 'package:flutter/material.dart';

import './screen/splash.dart';
import 'package:blue/src/helper.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blue',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: createMaterialColor(Color(0xFF041e42)),
        ),
        home: const SplashScreen());
  }
}