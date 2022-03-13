import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageUtils {
  final ImagePicker _picker = ImagePicker();

  ImageUtils();

  Future<List<XFile>?> pickImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    return images;
  }
}