import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:blue/src/provider/user.dart';
import 'package:blue/src/widget/profile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:blue/src/utils/image_utils.dart';
import 'package:provider/provider.dart';

class ProfileButton extends StatefulWidget {
  @override
  State<ProfileButton> createState() => ProfileButtonState();
}

class ProfileButtonState extends State<ProfileButton> {
  String profileImg = "assets/photos/basic-profile.jpg";
  bool isPicked = false;

  @override
  void initState() {
    if(context.read<UserProvider>().registerJson['profile'] == "") {
      pickOriginProfile();
    }
  }

  void pickFromGallery() async {
    late XFile? pickedImage;
    final ImageUtils _imageUtils = ImageUtils();
// late final base64Images;
    pickedImage = await _imageUtils.pickImgFromGallery();
    profileImg = await _imageUtils.imgToBase64(File(pickedImage?.path ?? ""));
    if (profileImg == "") {
      pickOriginProfile();
      return;
    } else
      isPicked = true;
    context.read<UserProvider>().registerJson['profile'] = profileImg;
    setState(() {});
  }

  void pickFromCamera() async {
    late XFile? pickedImage;
    final ImageUtils _imageUtils = ImageUtils();
    pickedImage = await _imageUtils.pickImgFromCamera();
    profileImg = await _imageUtils.imgToBase64(File(pickedImage?.path ?? ""));
    if (profileImg == "") {
      pickOriginProfile();
      return;
    } else
      isPicked = true;
    context.read<UserProvider>().registerJson['profile'] = profileImg;
    setState(() {});
  }

  void pickOriginProfile() async {
    profileImg = "assets/photos/basic-profile.jpg";
    ByteData bytes = await rootBundle.load(profileImg);
    var buffer = bytes.buffer;
    final originProfile = base64.encode(Uint8List.view(buffer));
    isPicked = false;
    context.read<UserProvider>().registerJson['profile'] = originProfile;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () async {
          ProfileBottomSheet().showProfileBottomSheet(
              context, pickFromGallery, pickFromCamera, pickOriginProfile);
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
                height: size.width * 0.5,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                    image: isPicked
                        ? DecorationImage(
                            image: MemoryImage(base64Decode(profileImg)),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: AssetImage(profileImg), fit: BoxFit.cover))),
            Positioned(
                child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.black54,
                size: 40,
              ),
            ))
          ],
        ));
  }
}
