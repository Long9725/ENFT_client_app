import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lottie/lottie.dart';

import '../page/getting_started.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  double _bigFontSize = 178;
  final transitionDuration = Duration(seconds: 1);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Future.delayed(Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        .then((value) => Duration(seconds: 1))
        .then(
          (value) => Future.delayed(Duration(seconds: 1)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => GettingStartedPage(title: "blue")),
                      (route) => false),
                ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
        child: Container(
            color: Color(0xFF041e42),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 700),
                      //a duration, set to one second
                      curve: Curves.fastOutSlowIn,
                      style: TextStyle(
                        color: Color(0xFFF6F2FE),
                        // our color from above, prefixed with 0xFF
                        fontSize: !expanded ? _bigFontSize : 50,
                        // change font size depending on expanded state
                        fontFamily: 'Montserrat',
                        // the font from Google Fonts
                        fontWeight: FontWeight.w600, //
                      ),
                      child: Text(
                        "E",
                      )),
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
                    secondChild: _logoRemainder(),
                    // a Row containing rest of our logo
                    alignment: Alignment.centerLeft,
                    // "reveal" the logo from the center left
                    sizeCurve: Curves.easeInOut,
                  ),
                ])));
  }

  Widget _logoRemainder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "XERCISE",
          style: TextStyle(
            color: Color(0xFFF6F2FE),
            fontSize: 50,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        LottieBuilder.asset(
          'assets/lottie/exercise.json',
          onLoaded: (composition) {
            _lottieAnimation..duration = composition.duration;
          },
          frameRate: FrameRate.max,
          repeat: false,
          animate: false,
          height: 100,
          width: 100,
          controller: _lottieAnimation,
        )
      ],
    );
  }
}
