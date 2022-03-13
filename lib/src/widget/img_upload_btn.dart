import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:blue/src/utils/image_utils.dart';

class ImgUploadBtn extends StatelessWidget {
  ImgUploadBtn({Key? key, required this.iconData, required this.pickedImgs}) : super(key: key);

  final IconData iconData;
  late final List<XFile>? pickedImgs;
  final ImageUtils _imageUtils = ImageUtils();

  void _pickImg() async {
    pickedImgs = await _imageUtils.pickImg();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      onPressed: _pickImg,
      icon: Icon(iconData,
          color:
              Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64)),
    );
  }
}
