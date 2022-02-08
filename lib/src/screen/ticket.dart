import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'package:blue/src/helper.dart';

enum _ColorTween { color1, color2 }

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => TicketScreenState();
}

class TicketScreenState extends State<TicketScreen>
    with TickerProviderStateMixin{
  final PageController _pageController = PageController(viewportFraction: 0.8);
  late AnimationController _controller;
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animationOne = ColorTween(begin: kPrimaryColor, end: kPrimaryColor.shade100)
        .animate(_controller);
    animationTwo = ColorTween(begin: kPrimaryColor.shade100, end: kPrimaryColor)
        .animate(_controller);

    _controller.repeat(max: 1);
    _controller.forward();

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
          return ShaderMask(
            child: Image(
              image: AssetImage("assets/backgrounds/ticket.png"),
            ),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [animationOne.value!, animationTwo.value!])
                  .createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
          );
          //   Container(
          //     decoration: BoxDecoration(
          //     image: DecorationImage(
          //     fit: BoxFit.fitHeight,
          //     image: AssetImage(
          //     "assets/backgrounds/ticket.png",
          // )),
          // ),);
        },
      ),
    )));
  }

// int _selectedIndex = 0;
// final PageController _pageController = PageController(viewportFraction: 0.8);
// var _currPageValue = 0.0;
// final double _scaleFactor = 0.8;
// Color bottomColor = kPrimaryColor;
// Color topColor = Colors.red;
//
// @override
// void initState() {
//   super.initState();
//   _pageController.addListener(() {
//     setState(() {
//       _currPageValue = _pageController.page!;
//       print(_currPageValue);
//     });
//   });
// }
//
// @override
// Widget build(BuildContext context) {
//   final width = MediaQuery.of(context).size.width * 0.8;
//   final height = width * 1.618;
//   return Scaffold(
//       body: Center(
//           child: SizedBox(
//     height: height,
//     child: PageView.builder(
//       onPageChanged: (index) {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//       controller: _pageController,
//       itemCount: 3,
//       itemBuilder: (BuildContext context, int index) {
//         return buildCard(index, height, width);
//       },
//     ),
//   )));
// }
//
// Widget buildCard(int index, double height, double width) {
//   Matrix4 matrix = Matrix4.identity();
//   var currOpacity = 1.0;
//   if (index == _currPageValue.floor()) {
//     var currScale = 1.0 - (_currPageValue - index) * (1.0 - _scaleFactor);
//     var currTrans = height * (1.0 - currScale) / 2.0;
//     matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//       ..setTranslationRaw(0.0, currTrans, 0.0);
//     currOpacity = currScale;
//   } else if (index == _currPageValue.floor() + 1) {
//     var currScale =
//         _scaleFactor + (_currPageValue - index + 1) * (1.0 - _scaleFactor);
//     var currTrans = height * (1.0 - currScale) / 2.0;
//     matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//       ..setTranslationRaw(0.0, currTrans, 0.0);
//     currOpacity = currScale - 0.2;
//   } else if (index == _currPageValue.floor() - 1) {
//     var currScale =
//         _scaleFactor + (_currPageValue - index - 1) * (1.0 - _scaleFactor);
//     var currTrans = height * (1.0 - currScale) / 2.0;
//     matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//       ..setTranslationRaw(0.0, currTrans, 0.0);
//     currOpacity = currScale - 0.2;
//   } else {
//     var currScale = 0.8;
//     matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//       ..setTranslationRaw(0.0, height * (1.0 - _scaleFactor) / 2.0, 0.0);
//     currOpacity = currScale - 0.2;
//   }
//
//   final tween = MultiTween<_ColorTween>()
//     ..add(_ColorTween.color1,
//         kPrimaryColor.tweenTo(Colors.lightBlue.shade900), 3.seconds)
//     ..add(_ColorTween.color2, kPrimaryColor.tweenTo(Colors.blue.shade900),
//         3.seconds);
//
//   return Container(
//       margin: const EdgeInsets.all(kDefaultPadding),
//       child: Transform(
//           transform: matrix,
//           child: Opacity(
//             opacity: currOpacity,
//             child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.fitHeight,
//                       image: AssetImage(
//                         "assets/backgrounds/ticket.png",
//                       )),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                         child: MirrorAnimation<MultiTweenValues<_ColorTween>>(
//                             tween: tween,
//                             duration: tween.duration,
//                             builder: (context, child, value) {
//                               return Container(
//                                   decoration: BoxDecoration(
//                                       color: kPrimaryColor,
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(16.0),
//                                           topRight: Radius.circular(16.0)),
//                                       gradient: LinearGradient(
//                                           begin: Alignment.bottomLeft,
//                                           end: Alignment.topRight,
//                                           colors: [
//                                             value.get<Color>(
//                                                 _ColorTween.color1),
//                                             value.get<Color>(
//                                                 _ColorTween.color2)
//                                           ])),
//                                   child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: kDefaultPadding,
//                                           horizontal: kDefaultPadding * 2),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.stretch,
//                                         children: [
//                                           Expanded(
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.end,
//                                                   children: [
//                                                 Text(
//                                                   "ENFT",
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 40.0,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       letterSpacing: 4.0),
//                                                 )
//                                               ])),
//                                           Text(
//                                             "ENFT\n헬스장 이용권",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 28.0,
//                                                 fontWeight:
//                                                     FontWeight.normal),
//                                           ),
//                                           SizedBox(
//                                             height: kDefaultPadding / 2,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Icon(Icons.favorite,
//                                                   color: Colors.white),
//                                               SizedBox(
//                                                 height: 0,
//                                                 width: kDefaultPadding / 2,
//                                               ),
//                                               Expanded(
//                                                   child: Text("헬스장 이름",
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                       ))),
//                                               Icon(Icons.share,
//                                                   color: Colors.white)
//                                             ],
//                                           )
//                                         ],
//                                       )));
//                             })),
//                     Container(
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(16.0),
//                                 bottomRight: Radius.circular(16.0))),
//                         child: Wrap(children: [
//                           Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: kDefaultPadding,
//                                   horizontal: kDefaultPadding * 2),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                         child: buildColumnTextItem(
//                                             '남은일수', 'D+180', true)),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         buildColumnTextItem(
//                                             '성명', '장성호', false),
//                                         const SizedBox(
//                                             height: kDefaultPadding,
//                                             width: 0),
//                                         buildColumnTextItem(
//                                             '등록날짜', '2022.01.30', false)
//                                       ],
//                                     )
//                                   ]))
//                         ]))
//                   ],
//                 )),
//           )));
// }
//
// Widget buildColumnTextItem(String title, String text, bool isBool) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(title),
//       const SizedBox(
//         height: kDefaultPadding / 4,
//         width: 0,
//       ),
//       Text(
//         text,
//         style: TextStyle(
//             fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
//             fontSize: isBool ? 26.0 : 14.0),
//       )
//     ],
//   );
// }
}

// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// import 'package:simple_animations/simple_animations.dart';
// import 'package:supercharged/supercharged.dart';
//
// import 'package:blue/src/helper.dart';
//
// enum _ColorTween { color1, color2 }
//
// class TicketScreen extends StatefulWidget {
//   const TicketScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TicketScreen> createState() => TicketScreenState();
// }
//
// class TicketScreenState extends State<TicketScreen> {
//   int _selectedIndex = 0;
//   final PageController _pageController = PageController(viewportFraction: 0.85);
//   var _currPageValue = 0.0;
//   final double _scaleFactor = 0.8;
//   Color bottomColor = kPrimaryColor;
//   Color topColor = Colors.red;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       setState(() {
//         _currPageValue = _pageController.page!;
//         print(_currPageValue);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width * 0.8;
//     final height = width * 1.618;
//     return Scaffold(
//         body: Center(
//             child: SizedBox(
//       height: height,
//       child: PageView.builder(
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         controller: _pageController,
//         itemCount: 3,
//         itemBuilder: (BuildContext context, int index) {
//           return buildCard(index, height, width);
//         },
//       ),
//     )));
//   }
//
//   Widget buildCard(int index, double height, double width) {
//     Matrix4 matrix = Matrix4.identity();
//     var currOpacity = 1.0;
//     if (index == _currPageValue.floor()) {
//       var currScale = 1.0 - (_currPageValue - index) * (1.0 - _scaleFactor);
//       var currTrans = height * (1.0 - currScale) / 2.0;
//       matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//         ..setTranslationRaw(0.0, currTrans, 0.0);
//       currOpacity = currScale;
//     } else if (index == _currPageValue.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currPageValue - index + 1) * (1.0 - _scaleFactor);
//       var currTrans = height * (1.0 - currScale) / 2.0;
//       matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//         ..setTranslationRaw(0.0, currTrans, 0.0);
//       currOpacity = currScale - 0.2;
//     } else if (index == _currPageValue.floor() - 1) {
//       var currScale =
//           _scaleFactor + (_currPageValue - index - 1) * (1.0 - _scaleFactor);
//       var currTrans = height * (1.0 - currScale) / 2.0;
//       matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//         ..setTranslationRaw(0.0, currTrans, 0.0);
//       currOpacity = currScale - 0.2;
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
//         ..setTranslationRaw(0.0, height * (1.0 - _scaleFactor) / 2.0, 0.0);
//       currOpacity = currScale - 0.2;
//     }
//
//     final tween = MultiTween<_ColorTween>()
//       ..add(_ColorTween.color1,
//           kPrimaryColor.tweenTo(Colors.lightBlue.shade900), 3.seconds)
//       ..add(_ColorTween.color2, kPrimaryColor.tweenTo(Colors.blue.shade900),
//           3.seconds);
//
//     return Container(
//         margin: const EdgeInsets.all(kDefaultPadding),
//         child: Transform(
//             transform: matrix,
//             child: Opacity(
//               opacity: currOpacity,
//               child: Card(
//                   elevation: kDefaultPadding,
//                   color: kPrimaryColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(16.0))),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Expanded(
//                           child: MirrorAnimation<MultiTweenValues<_ColorTween>>(
//                               tween: tween,
//                               duration: tween.duration,
//                               builder: (context, child, value) {
//                                 return Container(
//                                     decoration: BoxDecoration(
//                                         color: kPrimaryColor,
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(16.0),
//                                             topRight: Radius.circular(16.0)),
//                                         gradient: LinearGradient(
//                                             begin: Alignment.bottomLeft,
//                                             end: Alignment.topRight,
//                                             colors: [
//                                               value.get<Color>(
//                                                   _ColorTween.color1),
//                                               value.get<Color>(
//                                                   _ColorTween.color2)
//                                             ])),
//                                     child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: kDefaultPadding,
//                                             horizontal: kDefaultPadding * 2),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.stretch,
//                                           children: [
//                                             Expanded(
//                                                 child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.end,
//                                                     children: [
//                                                   Text(
//                                                     "ENFT",
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 40.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         letterSpacing: 4.0),
//                                                   )
//                                                 ])),
//                                             Text(
//                                               "ENFT\n헬스장 이용권",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 28.0,
//                                                   fontWeight:
//                                                       FontWeight.normal),
//                                             ),
//                                             SizedBox(
//                                               height: kDefaultPadding / 2,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.favorite,
//                                                     color: Colors.white),
//                                                 SizedBox(
//                                                   height: 0,
//                                                   width: kDefaultPadding / 2,
//                                                 ),
//                                                 Expanded(
//                                                     child: Text("헬스장 이름",
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                         ))),
//                                                 Icon(Icons.share,
//                                                     color: Colors.white)
//                                               ],
//                                             )
//                                           ],
//                                         )));
//                               })),
//                       Container(
//                           decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(16.0),
//                                   bottomRight: Radius.circular(16.0))),
//                           child: Wrap(children: [
//                             Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: kDefaultPadding,
//                                     horizontal: kDefaultPadding * 2),
//                                 child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                           child: buildColumnTextItem(
//                                               '남은일수', 'D+180', true)),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           buildColumnTextItem(
//                                               '성명', '장성호', false),
//                                           const SizedBox(
//                                               height: kDefaultPadding,
//                                               width: 0),
//                                           buildColumnTextItem(
//                                               '등록날짜', '2022.01.30', false)
//                                         ],
//                                       )
//                                     ]))
//                           ]))
//                     ],
//                   )),
//             )));
//   }
//
//   Widget buildColumnTextItem(String title, String text, bool isBool) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(title),
//         const SizedBox(
//           height: kDefaultPadding / 4,
//           width: 0,
//         ),
//         Text(
//           text,
//           style: TextStyle(
//               fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
//               fontSize: isBool ? 26.0 : 14.0),
//         )
//       ],
//     );
//   }
// }
