import 'dart:io';

import 'package:flutter/material.dart';

import 'package:blue/src/model/ChatMessage.dart';
import 'package:blue/src/widget/custom_stagger_grid.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({Key? key, required this.message}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return CustomStaggerGrid(images: message.images!);
  }
}
