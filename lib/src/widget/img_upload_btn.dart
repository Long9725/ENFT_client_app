import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'package:blue/src/provider/socket.dart';
import 'package:blue/src/utils/image_utils.dart';

class ImgUploadBtn extends StatefulWidget {
  ImgUploadBtn({Key? key, required this.iconData}) : super(key: key);

  final IconData iconData;

  @override
  ImgUploadBtnState createState() => ImgUploadBtnState();
}

class ImgUploadBtnState extends State<ImgUploadBtn> {
  List<XFile>? pickedImages = [];
  List<String> base64Images = [];
  final ImageUtils _imageUtils = ImageUtils();

  Future<void> _pickMultiImg() async {
    pickedImages = await _imageUtils.pickMultiImg();
    pickedImages?.forEach((element) async {
      final temp = await _imageUtils.imgToBase64(File(element.path));
      base64Images.add(temp);
      print("temp" + base64Images.toString());
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      onPressed: () async {
        await _pickMultiImg().then((value) {
          print("after" + base64Images.toString());
          context.read<SocketProvider>().sendImageMessage(base64Images);
        });
      },
      icon: Icon(widget.iconData,
          color:
              Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64)),
    );
  }
}
// class ImgUploadBtn extends StatelessWidget {
//   ImgUploadBtn({Key? key, required this.iconData})
//       : super(key: key);
//
//   final IconData iconData;
//   late final List<XFile>? pickedImages;
//   final List<String> base64Images = [];
//   final ImageUtils _imageUtils = ImageUtils();
//
//   Future<List<String>> _pickMultiImg() async {
//     pickedImages = await _imageUtils.pickMultiImg();
//     pickedImages?.forEach((element) async {
//       base64Images.add(await _imageUtils.imgToBase64(File(element.path)));
//       print("before:"+base64Images.toString());
//     });
//     print("result:"+base64Images.toString());
//     return base64Images;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return IconButton(
//       onPressed: () async {
//         print("after:"+base64Images.toString());
//         context.read<SocketProvider>().sendImageMessage(await _pickMultiImg());
//       },
//       icon: Icon(iconData,
//           color:
//               Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64)),
//     );
//   }
// }
