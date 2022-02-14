import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:blue/src/helper.dart';
import '../model/Slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
    Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Lottie.asset(slideList[index].imageUrl)),
    const SizedBox(height: kDefaultPadding*2),
    Text(slideList[index].title,
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).primaryColor,
        )),
    const SizedBox(height: kDefaultPadding),
    Text(
      slideList[index].descrption,
      textAlign: TextAlign.center,
    )
      ],
    );
  }
}
