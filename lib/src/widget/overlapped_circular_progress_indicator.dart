import 'package:flutter/material.dart';

class OverlappedCircularProgressIndicator extends StatelessWidget {
  const OverlappedCircularProgressIndicator({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.75,
        child: Container(
            height: height,
            width: width,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator())));
  }
}