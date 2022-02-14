import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/ticket/components/qr_code.dart';

class Ticket extends StatefulWidget {
  const Ticket(
      {Key? key,
      required this.currPageValue,
      required this.index,
      required this.description})
      : super(key: key);

  final double currPageValue;
  final int index;
  final Widget description;

  @override
  State<Ticket> createState() => TicketState();
}

class TicketState extends State<Ticket> with TickerProviderStateMixin {
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

    var currOpacity = 1.0;
    Matrix4 matrix = Matrix4.identity();

    if (widget.index == widget.currPageValue.floor()) {
      var currScale =
          1.0 - (widget.currPageValue - widget.index) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale;
    } else if (widget.index == widget.currPageValue.floor() + 1) {
      var currScale = _scaleFactor +
          (widget.currPageValue - widget.index + 1) * (1.0 - _scaleFactor);
      var currTrans = height * (1.0 - currScale) / 2.0;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      currOpacity = currScale - 0.2;
    } else if (widget.index == widget.currPageValue.floor() - 1) {
      var currScale = _scaleFactor +
          (widget.currPageValue - widget.index - 1) * (1.0 - _scaleFactor);
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
                          widget.description,
                          QRCode()
                        ],
                      ),
                    )
                  ]);
                })));
  }
}
