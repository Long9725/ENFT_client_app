import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'package:blue/src/provider/socket.dart';
import 'package:blue/src/utils/image_utils.dart';

class ImgUploadBtn extends StatelessWidget {
  ImgUploadBtn({Key? key, required this.iconData}) : super(key: key);

  final IconData iconData;
  late final List<XFile>? pickedImages;

  // late final base64Images;
  final ImageUtils _imageUtils = ImageUtils();

  Future<List<String>> _pickMultiImg() async {
    List<String> temp = [];
    pickedImages = await _imageUtils.pickMultiImg();
    // base64Images = await _addBase64ToList();
    // print(base64Images);
    return await _addBase64ToList();
  }

  Future<List<String>> _addBase64ToList() async {
    List<String> temp = [];
    await Future.forEach(pickedImages!, (XFile element) async {
      temp.add(await _imageUtils.imgToBase64(File(element.path)));
    });
    //         (element) async {
    //   temp.add(await _imageUtils.imgToBase64(File(element.path)));
    // });
    print("temp" + temp.toString());
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      onPressed: () async {
        await _pickMultiImg().then(
            (value) => context.read<SocketProvider>().sendImageMessage(value));
      },
      icon: Icon(iconData,
          color:
              Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64)),
    );
  }
}
