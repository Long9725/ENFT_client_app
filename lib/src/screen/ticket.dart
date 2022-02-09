import 'dart:math';
import 'dart:ui';

import 'package:blue/src/widget/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:blue/src/helper.dart';

enum _ColorTween { color1, color2 }

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => TicketScreenState();
}

class TicketScreenState extends State<TicketScreen>
    with TickerProviderStateMixin {
  // Page controller
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _selectedIndex = 0;
  var _currPageValue = 0.0;

  // Background gradient animation
  late AnimationController _backgroundGradientController;
  late Animation<Color?> _backgroundGradientAnimationForward;
  late Animation<Color?> _backgroundGradientAnimationReverse;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();

    // Background gradient animation
    _backgroundGradientController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _backgroundGradientAnimationForward =
        ColorTween(begin: kPrimaryColor, end: kPrimaryColor.shade300)
            .animate(_backgroundGradientController);
    _backgroundGradientAnimationReverse =
        ColorTween(begin: kPrimaryColor.shade300, end: kPrimaryColor)
            .animate(_backgroundGradientController);

    _backgroundGradientController.repeat(max: 1);
    _backgroundGradientController.forward();

    _backgroundGradientController.addListener(() {
      if (_backgroundGradientController.status == AnimationStatus.completed) {
        _backgroundGradientController.reverse();
      } else if (_backgroundGradientController.status ==
          AnimationStatus.dismissed) {
        _backgroundGradientController.forward();
      }
    });

    // Page controller
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _backgroundGradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    final height = width * 1.618;

    return Scaffold(
        body: Center(
            child: SizedBox(
                height: height,
                child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return FlipCardWidget(
                          controller: FlipCardController(),
                          front: buildFrontTicket(index, height, width),
                          back: buildBackTicket(index, height, width));
                    }))));
  }

  Widget buildFrontTicket(int index, double height, double width) {
    Matrix4 matrix = Matrix4.identity();
    var currOpacity = 1.0;
    if (index == _currPageValue.floor()) {
      var currScale = 1.0 - (_currPageValue - index) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale;
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale - 0.2;
    } else if (index == _currPageValue.floor() - 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index - 1) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale - 0.2;
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, height * (1.0 - _scaleFactor) / 2.0, 0.0);
      currOpacity = currScale - 0.2;
    }

    return Transform(
        transform: matrix,
        child: Opacity(
            opacity: currOpacity,
            child: AnimatedBuilder(
                animation: _backgroundGradientController,
                builder: (_, child) {
                  return Stack(alignment: Alignment.center, children: [
                    ShaderMask(
                      child: Image(
                        image: AssetImage("assets/backgrounds/ticket.png"),
                      ),
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              _backgroundGradientAnimationForward.value!,
                              _backgroundGradientAnimationReverse.value!
                            ]).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Text("HK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4.0)),
                          )),
                          Text(
                            "ENFT\n헬스장 이용권",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.white),
                              SizedBox(
                                height: 0,
                                width: kDefaultPadding / 2,
                              ),
                              Expanded(
                                  child: Text("아주대학교 헬스장",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              Icon(Icons.share, color: Colors.white)
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("전자출입\nQR  코드",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("오늘도 안전한\n편리한 헬스장",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )),
                                ],
                              )),
                              QrImage(
                                data: "https://www.naver.com",
                                backgroundColor: Colors.white,
                                size: 125,
                              )
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding / 8,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 3,
                          ),
                        ],
                      ),
                    )
                  ]);
                })));
  }

  Widget buildBackTicket(int index, double height, double width) {
    Matrix4 matrix = Matrix4.identity();
    var currOpacity = 1.0;
    if (index == _currPageValue.floor()) {
      var currScale = 1.0 - (_currPageValue - index) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale;
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale - 0.2;
    } else if (index == _currPageValue.floor() - 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index - 1) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale - 0.2;
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, height * (1.0 - _scaleFactor) / 2.0, 0.0);
      currOpacity = currScale - 0.2;
    }

    return Transform(
        transform: matrix,
        child: Opacity(
            opacity: currOpacity,
            child: AnimatedBuilder(
                animation: _backgroundGradientController,
                builder: (_, child) {
                  return Stack(alignment: Alignment.center, children: [
                    ShaderMask(
                      child: Image(
                        image: AssetImage("assets/backgrounds/ticket.png"),
                      ),
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              _backgroundGradientAnimationForward.value!,
                              _backgroundGradientAnimationReverse.value!
                            ]).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("전자출입\nQR  코드",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("오늘도 안전한\n편리한 헬스장",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )),
                                ],
                              )),
                              QrImage(
                                data: "https://www.naver.com",
                                backgroundColor: Colors.white,
                                size: 125,
                              )
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding / 8,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 3,
                          ),
                        ],
                      ),
                    )
                  ]);
                })));
  }
}
