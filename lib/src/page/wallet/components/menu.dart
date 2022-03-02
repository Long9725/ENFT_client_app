import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:lottie/lottie.dart';

import 'package:blue/src/helper.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  bool isTap = false;

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    super.initState();
  }

  @override
  void dispose() {
    _lottieAnimation.dispose();
    super.dispose();
  }

  void forwardLottieAnimation() {
    setState(() {
      isTap = !isTap;
    });
    var completer = CancelableCompleter(onCancel: delayStopLottieAnimation);
    completer.complete();
    _lottieAnimation.forward(from: 0.3);
  }

  void delayStopLottieAnimation() {
    Future.delayed(Duration(
        milliseconds: _lottieAnimation.duration!.inMilliseconds ~/ 2))
        .whenComplete(() {
      if (isTap) _lottieAnimation.stop(canceled: true);
    });
  }

  void reverseLottieAnimation() {
    setState(() {
      isTap = !isTap;
    });
    _lottieAnimation.reverse().whenComplete(() {
      if (!isTap) _lottieAnimation.stop(canceled: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: isTap ? reverseLottieAnimation : forwardLottieAnimation,
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
            child: OverflowBox(
              maxHeight: 200,
              maxWidth: 200,
              child: Lottie.asset('assets/lottie/grid.json', fit: BoxFit.fill,
                  onLoaded: (composition) {
                _lottieAnimation.duration = composition.duration;
              },
                  frameRate: FrameRate.max,
                  repeat: false,
                  animate: false,
                  controller: _lottieAnimation),
            )));
  }
}
