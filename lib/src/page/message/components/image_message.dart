import 'dart:io';

import 'package:flutter/material.dart';

import 'package:blue/src/widget/custom_stagger_grid.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({Key? key, required this.images}) : super(key: key);

  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return CustomStaggerGrid(images: images);
  }
}
