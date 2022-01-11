import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
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
        const SizedBox(height: 40),
        Text(slideList[index].title,
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
            )),
        const SizedBox(height: 10),
        Text(
          slideList[index].descrption,
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
